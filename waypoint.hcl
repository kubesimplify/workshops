project = "workshops"

variable "user" {
    type = string
}
variable "password" {
    type = string
}
variable "DOMAIN" {
    type = string
 }

variable "STATIC_DIR" {
type = string
}

variable "PUBLISHABLE_KEY"{
type  = string
}

variable "SECRET_KEY"{
type =  string
}

app "demo" {
    build {
        use "pack" {} 
        registry {
          use "docker" {
            image = "saiyam911/workshops"
            tag   = "${substr(gitrefhash(), 0, 7)}-${formatdate("YYYYMMDD-hhmmss", timestamp())}"
            local = false
            username = var.user
            password = var.password
          }
        }

    }
    deploy { 
      use "kubernetes" {
          service_port = 3000
  }
    }

    release {
      use "kubernetes" {
        node_port = 31769
        port = 3000
      }
    }
}
