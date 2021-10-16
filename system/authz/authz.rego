package system.authz

default allow = false

allow {
	input.method = "POST"
	input.path = ["v1", "data", "org", "robojackets", "concourse"]
}

allow {
	input.method = "GET"
	input.path = ["metrics"]
}
