package org.robojackets.concourse.setpipeline

test_privileged_resource_types_disallowed {
	reasons == {"privileged resources are not allowed"} with input as {"data": {"resource_types": [{
		"privileged": true, "source": {"repository": "asdf"},
		"tags": ["resources"],
	}]}}
}

test_some_privileged_resource_types_disallowed {
	reasons == {"privileged resources are not allowed"} with input as {"data": {"resource_types": [
		{
			"privileged": true, "source": {"repository": "asdf"},
			"tags": ["resources"],
		},
		{
			"privileged": false, "source": {"repository": "jkl"},
			"tags": ["resources"],
		},
	]}}
}

test_non_privileged_resource_types_allowed {
	not reasons["privileged resources are not allowed"] with input as {"data": {"resource_types": [
		{"privileged": false, "tags": ["resources"]},
		{"privileged": false, "tags": ["resources"]},
	]}}
}

test_non_tagged_resource_types_disallowed {
	reasons == {"resource_types must have tag 'resources'"} with input as {"data": {"resource_types": [{
		"privileged": false,
		"source": {"repository": "asdf"},
	}]}}
}

test_some_non_tagged_resource_types_disallowed {
	reasons == {"resource_types must have tag 'resources'"} with input as {"data": {"resource_types": [
		{"privileged": false, "source": {"repository": "asdf"}},
		{
			"privileged": false, "source": {"repository": "jkl"},
			"tags": ["resources"],
		},
	]}}
}

test_incorrectly_tagged_resource_types_disallowed {
	reasons == {"resource_types must have tag 'resources'"} with input as {"data": {"resource_types": [{
		"privileged": false, "source": {"repository": "asdf"},
		"tags": ["something else"],
	}]}}
}

test_some_incorrectly_tagged_resource_types_disallowed {
	reasons == {"resource_types must have tag 'resources'"} with input as {"data": {"resource_types": [
		{
			"privileged": false, "source": {"repository": "asdf"},
			"tags": ["something else"],
		},
		{
			"privileged": false, "source": {"repository": "jkl"},
			"tags": ["resources"],
		},
	]}}
}

test_tagged_resource_types_allowed {
	not reasons["resource_types must have tag 'resources'"] with input as {"data": {"resource_types": [
		{"tags": ["resources"]},
		{"tags": ["resources"]},
	]}}
}

test_registry_image_resource_types_allowed {
	not reasons["resource_types must have type 'registry-image'"] with input as {"data": {"resource_types": [{
		"tags": ["resources"],
		"type": "registry-image",
	}]}}
}

test_other_type_resource_types_disallowed {
	reasons == {"resource_types must have type 'registry-image'"} with input as {"data": {"resource_types": [{
		"source": {"repository": "asdf"},
		"tags": ["resources"], "type": "docker-image",
	}]}}
}

test_distinct_resource_types_allowed {
	not reasons["resource_types must have unique source.repository values"] with input as {"data": {"resource_types": [
		{"source": {"repository": "a"}},
		{"source": {"repository": "b"}},
	]}}
}

test_duplicate_resource_types_disallowed {
	reasons == {"resource_types must have unique source.repository values"} with input as {"data": {"resource_types": [
		{
			"source": {"repository": "a"},
			"tags": ["resources"],
			"type": "registry-image",
		},
		{
			"source": {"repository": "a"},
			"tags": ["resources"],
			"type": "registry-image",
		},
	]}}
}
