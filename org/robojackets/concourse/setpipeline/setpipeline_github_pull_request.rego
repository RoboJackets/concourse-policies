package org.robojackets.concourse.setpipeline

reasons["teliaoss/github-pr-resource resources must authenticate with an app token"] {
	count({x |
		input.data.resources[x]
		input.data.resources[x].type == pull_request_resource_type_name
		input.data.resources[x].source.access_token == "((\"github.com\"/token.token))"
	}) + count({x |
		input.data.resources[x]
		input.data.resources[x].type == pull_request_resource_type_name
		input.data.resources[x].source.access_token == "((\"github.gatech.edu\"/token.token))"
	}) != count({x |
		input.data.resources[x]
		input.data.resources[x].type == pull_request_resource_type_name
	})
}

all_pull_request_resource_type_names[name] {
	some i
	input.data.resource_types[i].source.repository == "teliaoss/github-pr-resource"
	name := input.data.resource_types[i].name
}

pull_request_resource_type_name = name {
	name := [x | all_pull_request_resource_type_names[x]][0]
}

reasons["a maximum of one teliaoss/github-pr-resource resource is allowed"] {
	count({x |
		input.data.resources[x]
		input.data.resources[x].type == pull_request_resource_type_name
	}) > 1
}

all_pull_request_resource_names[name] {
	some i
	input.data.resources[i].type == pull_request_resource_type_name
	name := input.data.resources[i].name
}

pull_request_resource_name = name {
	name := [x | all_pull_request_resource_names[x]][0]
}

default forks_from_pull_requests_are_ignored = false

forks_from_pull_requests_are_ignored {
	some i
	input.data.resources[i].name == pull_request_resource_name
	input.data.resources[i].source.disable_forks == true
}

jobs_that_are_triggered_by_pull_requests[job_name] {
	some i
	job_name := input.data.jobs[i].name
	[path, value] := walk(input.data.jobs[i])
	value.get == pull_request_resource_name
	value.trigger == true
}

jobs_that_have_privileged_tasks[job_name] {
	some i
	job_name := input.data.jobs[i].name
	[path, value] := walk(input.data.jobs[i])
	value.task
	value.privileged == true
}

reasons["jobs triggered by pull requests from forks must not use privileged tasks"] {
	forks_from_pull_requests_are_ignored == false
	count(jobs_that_have_privileged_tasks & jobs_that_are_triggered_by_pull_requests) > 0
}
