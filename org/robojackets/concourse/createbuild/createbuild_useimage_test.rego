package org.robojackets.concourse.createbuild

test_docker_image_disallowed {
	reasons == {"image type must be registry-image"} with input as {
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
								"type": "docker-image",
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

test_registry_image_allowed {
	not reasons["image type must be registry-image"] with input as {
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

test_privileged_image_disallowed {
	reasons == {"only concourse/oci-build-task is allowed to run in a privileged container"} with input as {
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
						"privileged": true,
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

test_oci_build_privileged_allowed {
	not reasons["only concourse/oci-build-task is allowed to run in a privileged container"] with input as {
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
								"source": {"repository": "concourse/oci-build-task"},
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
						"privileged": true,
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

test_oci_build_privileged_required {
	reasons == {"concourse/oci-build-task requires a privileged container"} with input as {
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
								"source": {"repository": "concourse/oci-build-task"},
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
