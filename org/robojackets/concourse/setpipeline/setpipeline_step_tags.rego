package org.robojackets.concourse.setpipeline

reasons["steps must not be tagged with `resources`"] {
	[path, value] := walk(input.data.jobs[_])
	value.tags
	value.tags[_] == "resources"
}
