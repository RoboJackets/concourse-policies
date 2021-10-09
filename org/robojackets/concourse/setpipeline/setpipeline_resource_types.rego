package org.robojackets.concourse.setpipeline

reasons["privileged resources are not allowed"] {
	input.data.resource_types[_].privileged
}

reasons["resource_types must have type 'registry-image'"] {
	input.data.resource_types[_].type != "registry-image"
}

reasons["resource_types must have tag 'resources'"] {
	count({x |
		input.data.resource_types[x]
		input.data.resource_types[x].tags == ["resources"]
	}) != count(input.data.resource_types)
}

source_repository[source_repository] {
	source_repository := input.data.resource_types[_].source.repository
}

reasons["resource_types must have unique source.repository values"] {
	count(input.data.resource_types) != count(source_repository)
}
