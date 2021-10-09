package org.robojackets.concourse.setpipeline

test_resource_types_name_detection {
	pull_request_resource_type_name == "asdfjkl" with input as {"data": {"resource_types": [{
		"name": "asdfjkl",
		"source": {"repository": "teliaoss/github-pr-resource"},
		"type": "registry-image",
	}]}}
}

test_two_resource_types_name_detection {
	reasons == {"resource_types must have unique source.repository values"} with input as {"data": {"resource_types": [
		{
			"name": "asdfjkl1",
			"source": {"repository": "teliaoss/github-pr-resource"},
			"tags": ["resources"], "type": "registry-image",
		},
		{
			"name": "asdfjkl2",
			"source": {"repository": "teliaoss/github-pr-resource"},
			"tags": ["resources"], "type": "registry-image",
		},
	]}}
}

test_more_than_one_pull_request_resource_is_disallowed {
	reasons == {"a maximum of one teliaoss/github-pr-resource resource is allowed"} with input as {"data": {
		"resource_types": [{
			"name": "asdfjkl",
			"source": {"repository": "teliaoss/github-pr-resource"},
			"tags": ["resources"], "type": "registry-image",
		}],
		"resources": [
			{
				"source": {"access_token": "((\"github.com\"/token.token))"},
				"tags": ["resources"], "type": "asdfjkl",
			},
			{
				"source": {"access_token": "((\"github.com\"/token.token))"},
				"tags": ["resources"], "type": "asdfjkl",
			},
		],
	}}
}

test_pull_request_disable_forks_true {
	forks_from_pull_requests_are_ignored == true with input as {"data": {
		"resource_types": [{
			"name": "asdfjkl",
			"source": {"repository": "teliaoss/github-pr-resource"},
			"tags": ["resources"], "type": "registry-image",
		}],
		"resources": [{
			"name": "thisisapullrequest",
			"source": {
				"access_token": "((\"github.com\"/token.token))",
				"disable_forks": true,
			},
			"tags": ["resources"], "type": "asdfjkl",
		}],
	}}
}

test_pull_request_disable_forks_false {
	forks_from_pull_requests_are_ignored == false with input as {"data": {
		"resource_types": [{
			"name": "asdfjkl",
			"source": {"repository": "teliaoss/github-pr-resource"},
			"tags": ["resources"], "type": "registry-image",
		}],
		"resources": [{
			"name": "thisisapullrequest",
			"source": {
				"access_token": "((\"github.com\"/token.token))",
				"disable_forks": false,
			},
			"tags": ["resources"], "type": "asdfjkl",
		}],
	}}
}

test_pull_request_disable_forks_missing {
	forks_from_pull_requests_are_ignored == false with input as {"data": {
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

test_jobs_that_are_triggered_by_pull_requests_true {
	jobs_that_are_triggered_by_pull_requests == {"thisisajobname"} with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [{
				"get": "thisisapullrequest",
				"trigger": true,
			}],
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

test_jobs_that_are_triggered_by_pull_requests_false {
	not jobs_that_are_triggered_by_pull_requests.thisisajobname with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [{
				"get": "thisisapullrequest",
				"trigger": false,
			}],
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

test_jobs_that_are_triggered_by_pull_requests_missing {
	not jobs_that_are_triggered_by_pull_requests.thisisajobname with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [{"get": "thisisapullrequest"}],
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

test_jobs_that_have_privileged_tasks_true {
	jobs_that_have_privileged_tasks == {"thisisajobname"} with input as {"data": {"jobs": [{
		"name": "thisisajobname",
		"plan": [{"privileged": true, "task": "is-privileged"}],
	}]}}
}

test_jobs_that_have_privileged_tasks_false {
	not jobs_that_have_privileged_tasks.thisisajobname with input as {"data": {"jobs": [{
		"name": "thisisajobname",
		"plan": [{"privileged": false, "task": "is-privileged"}],
	}]}}
}

test_jobs_that_have_privileged_tasks_missing {
	not jobs_that_have_privileged_tasks.thisisajobname with input as {"data": {"jobs": [{
		"name": "thisisajobname",
		"plan": [{"task": "is-privileged"}],
	}]}}
}

test_jobs_triggered_by_pull_requests_true {
	reasons == {"jobs triggered by pull requests from forks must not use privileged tasks"} with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [
				{
					"get": "thisisapullrequest",
					"trigger": true,
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

test_jobs_triggered_by_pull_requests_false_because_not_triggered {
	not reasons["jobs triggered by pull requests from forks must not use privileged tasks"] with input as {"data": {
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

test_jobs_triggered_by_pull_requests_false_because_not_privileged {
	not reasons["jobs triggered by pull requests from forks must not use privileged tasks"] with input as {"data": {
		"jobs": [{
			"name": "thisisajobname",
			"plan": [
				{
					"get": "thisisapullrequest",
					"trigger": true,
				},
				{"privileged": false, "task": "do-something-with-the-pull-request"},
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
