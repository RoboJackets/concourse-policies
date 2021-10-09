package org.robojackets.concourse.setpipeline

reasons["resources must have tag 'resources'"] {
	count({x |
		input.data.resources[x]
		input.data.resources[x].tags == ["resources"]
	}) != count(input.data.resources)
}
