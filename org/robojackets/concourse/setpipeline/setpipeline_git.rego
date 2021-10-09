package org.robojackets.concourse.setpipeline

reasons["git resources must authenticate with an app token"] {
	count({x |
		input.data.resources[x]
		input.data.resources[x].type == "git"
		input.data.resources[x].source.username == "x-access-token"
		input.data.resources[x].source.password == "((\"github.com\"/token.token))"
	}) + count({x |
		input.data.resources[x]
		input.data.resources[x].type == "git"
		input.data.resources[x].source.username == "x-access-token"
		input.data.resources[x].source.password == "((\"github.gatech.edu\"/token.token))"
	}) != count({x |
		input.data.resources[x]
		input.data.resources[x].type == "git"
	})
}
