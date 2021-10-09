package org.robojackets.concourse.setpipeline

test_tagged_resource_types_allowed {
	not reasons["resource_types must have tag 'resources'"] with input as {"data": {"resource_types": [
		{"tags": ["resources"]},
		{"tags": ["resources"]},
	]}}
}

test_untagged_resources_disallowed {
	reasons == {"resources must have tag 'resources'"} with input as {"data": {"resources": [
		{"tags": []},
		{"tags": []},
	]}}
}

test_tagged_resources_allowed {
	not reasons["resources must have tag 'resources'"] with input as {"data": {"resources": [
		{"tags": ["resources"]},
		{"tags": ["resources"]},
	]}}
}
