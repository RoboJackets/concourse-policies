package org.robojackets.concourse.setpipeline

test_docker_image_not_allowed {
	reasons == {"image type must be registry-image"} with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [
				{
					"get": "thisisapullrequest",
					"trigger": true,
				},
				{
					"config": {"image_resource": {"type": "docker-image"}},
					"privileged": false,
					"task": "do-something-with-the-pull-request",
				},
			],
		}],
		"resource_types": [{
			"name": "asdfjkl",
			"source": {"repository": "teliaoss/github-pr-resource"},
			"tags": ["resources"], "type": "registry-image",
		}],
		"resources": [{
			"name": "thisisapullrequest",
			"source": {"access_token": "((\"github.com\"/token.token))"},
			"tags": ["resources"], "type": "asdfjkl",
		}],
	}}
}

test_registry_image_allowed {
	not reasons["image type must be registry-image"] with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [
				{
					"get": "thisisapullrequest",
					"trigger": true,
				},
				{
					"config": {"image_resource": {"type": "registry-image"}},
					"privileged": false,
					"task": "do-something-with-the-pull-request",
				},
			],
		}],
		"resource_types": [{
			"name": "asdfjkl",
			"source": {"repository": "teliaoss/github-pr-resource"},
			"tags": ["resources"], "type": "registry-image",
		}],
		"resources": [{
			"name": "thisisapullrequest",
			"source": {"access_token": "((\"github.com\"/token.token))"},
			"tags": ["resources"], "type": "asdfjkl",
		}],
	}}
}

test_privileged_task_not_allowed {
	reasons == {"only concourse/oci-build-task is allowed to run in a privileged container"} with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [
				{
					"get": "thisisapullrequest",
					"trigger": false,
				},
				{
					"config": {"image_resource": {
						"source": {"repository": "asdf"},
						"type": "registry-image",
					}},
					"privileged": true,
					"task": "do-something-with-the-pull-request",
				},
			],
		}],
		"resource_types": [{
			"name": "asdfjkl",
			"source": {"repository": "teliaoss/github-pr-resource"},
			"tags": ["resources"], "type": "registry-image",
		}],
		"resources": [{
			"name": "thisisapullrequest",
			"source": {"access_token": "((\"github.com\"/token.token))"},
			"tags": ["resources"], "type": "asdfjkl",
		}],
	}}
}

test_oci_build_task_allowed {
	not reasons["only concourse/oci-build-task is allowed to run in a privileged container"] with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [
				{
					"get": "thisisapullrequest",
					"trigger": false,
				},
				{
					"config": {"image_resource": {
						"source": {"repository": "concourse/oci-build-task"},
						"type": "registry-image",
					}},
					"privileged": true,
					"task": "do-something-with-the-pull-request",
				},
			],
		}],
		"resource_types": [{
			"name": "asdfjkl",
			"source": {"repository": "teliaoss/github-pr-resource"},
			"tags": ["resources"], "type": "registry-image",
		}],
		"resources": [{
			"name": "thisisapullrequest",
			"source": {"access_token": "((\"github.com\"/token.token))"},
			"tags": ["resources"], "type": "asdfjkl",
		}],
	}}
}

test_oci_build_task_must_be_privileged {
	reasons == {"concourse/oci-build-task requires a privileged container"} with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [
				{
					"get": "thisisapullrequest",
					"trigger": false,
				},
				{
					"config": {"image_resource": {
						"source": {"repository": "concourse/oci-build-task"},
						"type": "registry-image",
					}},
					"privileged": false,
					"task": "do-something-with-the-pull-request",
				},
			],
		}],
		"resource_types": [{
			"name": "asdfjkl",
			"source": {"repository": "teliaoss/github-pr-resource"},
			"tags": ["resources"], "type": "registry-image",
		}],
		"resources": [{
			"name": "thisisapullrequest",
			"source": {"access_token": "((\"github.com\"/token.token))"},
			"tags": ["resources"], "type": "asdfjkl",
		}],
	}}
}
