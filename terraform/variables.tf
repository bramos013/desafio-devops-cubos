variable "POSTGRES_USER" {
    type = string
    default = "admin"
}

variable "POSTGRES_PASSWORD" {
    type = string
    default = "secure_p4$$w0rd"
}

variable "POSTGRES_DB" {
    type = string
    default = "cubos"
}

variable "user" {
    type = string
    default = "admin"
}

variable "pass" {
    type = string
    default = "secure_p4$$w0rd"
}

variable "host" {
    type    = string
    default = "cubos-sql"
}

variable "db_port" {
    type    = number
    default = 5432
}

variable "database" {
    type    = string
    default = "cubos"
}

variable "frontend_port" {
    type    = number
    default = 80
}
