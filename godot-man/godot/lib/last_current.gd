extends Node
class_name LastCurrent

var last
var current

func of(x) -> LastCurrent:
  last = x
  current = x
  return self

func change(new_value) -> LastCurrent:
  last = current
  current = new_value
  return self
