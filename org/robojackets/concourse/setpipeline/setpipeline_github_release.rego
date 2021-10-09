package org.robojackets.concourse.setpipeline

reasons["github-release resources must authenticate with an app token"] {
	count({x |
		input.data.resources[x]
		input.data.resources[x].type == "github-release"
		input.data.resources[x].source.access_token == "((\"github.com\"/token.token))"
	}) + count({x |
		input.data.resources[x]
		input.data.resources[x].type == "github-release"
		input.data.resources[x].source.access_token == "((\"github.gatech.edu\"/token.token))"
	}) != count({x |
		input.data.resources[x]
		input.data.resources[x].type == "github-release"
	})
}
