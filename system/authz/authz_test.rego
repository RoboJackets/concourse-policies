package system.authz

test_get_disallowed {
	not allow with input as {"method": "GET"}
}

test_post_something_disallowed {
	not allow with input as {"method": "POST", "path": ["v1", "data", "something"]}
}

test_post_concourse_allowed {
	allow with input as {"method": "POST", "path": ["v1", "data", "org", "robojackets", "concourse"]}
}
