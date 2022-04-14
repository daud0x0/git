#!/bin/sh

. ${0%/*}/lib-ci-type.sh

set -e

case "$CI_TYPE" in
github-actions)
	handle_failed_tests () {
		mkdir -p t/failed-test-artifacts
		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV

		for test_exit in t/test-results/*.exit
		do
			test 0 != "$(cat "$test_exit")" || continue

			test_name="${test_exit%.exit}"
			test_name="${test_name##*/}"
			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
			cat "t/test-results/$test_name.markup"

			trash_dir="t/trash directory.$test_name"
			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
			tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
		done
		return 1
	}
	;;
*)
	echo "Unhandled CI type: $CI_TYPE" >&2
	exit 1
	;;
esac

handle_failed_tests
