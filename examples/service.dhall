let Prelude =
      ../Prelude.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e

let kubernetes =
      ../package.dhall sha256:7150ac4309a091740321a3a3582e7695ee4b81732ce8f1ed1691c1c52791daa1

let spec =
      { selector = Some (toMap { app = "nginx" })
      , type = Some "NodePort"
      , ports = Some
        [ kubernetes.ServicePort::{
          , targetPort = Some (kubernetes.IntOrString.Int 80)
          , port = 80
          }
        ]
      }

let service
    : kubernetes.Service.Type
    = kubernetes.Service::{
      , metadata = kubernetes.ObjectMeta::{
        , name = Some "nginx"
        , labels = Some (toMap { app = "nginx" })
        }
      , spec = Some kubernetes.ServiceSpec::spec
      }

in  service
