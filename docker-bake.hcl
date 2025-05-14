variable "registry" {
  description = "The registry to use for the images"
  type = string
  default = "docker.io/library"
}

variable "version" {
  description = "The version of the images"
  type = string
  default = null
}

variable "latest" {
  description = "Whether to also tag the images with 'latest'"
  type = bool
  default = true
}

function "repo" {
  params = [name]
  result = "${registry}/${name}"
}

function "tags" {
  params = [name]
  result = [
    version != null ? "${repo(name)}:${version}" : "",
    latest ? "${repo(name)}:latest" : "",
  ]
}

group "all" {
  targets = [ 
    "bar", 
    "baz",
    "foo"
  ]
}

target "_common" {
  context = "."
  dockerfile = "Dockerfile"
}

target "bar" {
  inherits = [ "_common" ]
  tags = tags("bar")
  args = {
    APP = "Bar.Api"
  }
}

target "baz" {
  inherits = [ "_common" ]
  tags = tags("baz")
  args = {
    APP = "Baz.Api"
  }
}

target "foo" {
  inherits = [ "_common" ]
  tags = tags("foo")
  args = {
    APP = "Foo.Api"
  }
}