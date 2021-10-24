package org.robojackets.concourse.createbuild

reasons["one-off builds must not be tagged"] {
	[path, value] := walk(input.data.do[_])
	value.name == "one-off"
	value.tags
}
