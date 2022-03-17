package org.robojackets.concourse.setpipeline

reasons["steps must not be tagged"] {
	[path, value] := walk(input.data.jobs[_])
	value.tags
}
