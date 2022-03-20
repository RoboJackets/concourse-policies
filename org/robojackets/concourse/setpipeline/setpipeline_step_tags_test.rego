package org.robojackets.concourse.setpipeline

test_resources_tagged_step_disallowed {
	reasons == {"steps must not be tagged with `resources`"} with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [
				{
					"get": "thisisapullrequest",
					"tags": ["resources"], "trigger": false,
				},
				{"privileged": true, "task": "do-something-with-the-pull-request"},
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

test_other_tagged_step_allowed {
	not reasons["steps must not be tagged with `resources`"] with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [
				{
					"get": "thisisapullrequest",
					"tags": ["somevalue"], "trigger": false,
				},
				{"privileged": true, "task": "do-something-with-the-pull-request"},
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

test_untagged_step_allowed {
	not reasons["steps must not be tagged with `resources`"] with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [
				{
					"get": "thisisapullrequest",
					"trigger": false,
				},
				{"privileged": true, "task": "do-something-with-the-pull-request"},
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
