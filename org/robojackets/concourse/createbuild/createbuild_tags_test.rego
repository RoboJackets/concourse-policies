package org.robojackets.concourse.createbuild

test_tagged_step_disallowed {
	reasons == {"one-off builds must not be tagged"} with input as {
		"action": "CreateBuild",
		"cluster_name": "sandbox",
		"cluster_version": "7.5.0",
		"data": {
			"do": [
				{
					"id": "61757930",
					"in_parallel": {"steps": [{
						"artifact_input": {
							"artifact_id": 14,
							"name": "source",
						},
						"id": "6175792e",
					}]},
				},
				{
					"id": "6175792f",
					"task": {
						"config": {
							"image_resource": {
								"name": "",
								"source": {"repository": "alpine/git"},
								"type": "registry-image",
							},
							"inputs": [{"name": "source"}],
							"outputs": [{"name": "commit-sha"}],
							"platform": "linux",
							"run": {
								"args": [
									"-e",
									"-x",
									"-c",
									"git -C source rev-parse HEAD \\u003e commit-sha/value",
								],
								"path": "sh",
							},
						},
						"name": "one-off",
						"privileged": false,
						"tags": ["resources"],
					},
				},
			],
			"id": "61757931",
		},
		"http_method": "POST",
		"roles": ["owner"],
		"service": "concourse",
		"team": "information-technology",
		"user": "kberzinch3",
	}
}

test_untagged_step_allowed {
	not reasons["one-off builds must not be tagged"] with input as {
		"action": "CreateBuild",
		"cluster_name": "sandbox",
		"cluster_version": "7.5.0",
		"data": {
			"do": [
				{
					"id": "61757930",
					"in_parallel": {"steps": [{
						"artifact_input": {
							"artifact_id": 14,
							"name": "source",
						},
						"id": "6175792e",
					}]},
				},
				{
					"id": "6175792f",
					"task": {
						"config": {
							"image_resource": {
								"name": "",
								"source": {"repository": "alpine/git"},
								"type": "registry-image",
							},
							"inputs": [{"name": "source"}],
							"outputs": [{"name": "commit-sha"}],
							"platform": "linux",
							"run": {
								"args": [
									"-e",
									"-x",
									"-c",
									"git -C source rev-parse HEAD \\u003e commit-sha/value",
								],
								"path": "sh",
							},
						},
						"name": "one-off",
						"privileged": false,
					},
				},
			],
			"id": "61757931",
		},
		"http_method": "POST",
		"roles": ["owner"],
		"service": "concourse",
		"team": "information-technology",
		"user": "kberzinch3",
	}
}
