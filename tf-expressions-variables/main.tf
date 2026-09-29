terraform {}

# number list
variable "number_list" {
    type = list(number)
    default = [1,2,3,4]
}

# object list
variable "object_list" {
    type = list(object({
        name = string
        age = number
    }))
    default = [{
        name = "kamran"
        age = 22
    }, {
        name = "ahmed",
        age = 18
    }]
}

# map 
variable "map"{
    type = map(number)
    default = {
        key1 = 10
        key2 = 20
        key3 = 30
    }
}

locals {
    num = 2 * 2
    addition = 2 + 2

    #operations on num list
    num1 = [for n in var.number_list : n * 2]
    num2 = [for n in var.number_list : n if n % 2 != 0] 
    num3 = [for n in var.number_list : n if n > 3]

    #operations on object list
    obj1 = [for o in var.object_list : o ]
    obj2 = [for o in var.object_list : o.name ]
    obj3 = [for o in var.object_list : o.age ]
    obj4 = [for o in var.object_list : o.name if o.age > 18 ]

    #operations on map list
    map1 = [for k, v in var.map : k ]
    map2 = {for k, v in var.map : k => v}
    map3 = {for k, v in var.map : k => v * 2}
}

output "value" {
    value = local.map3
}

