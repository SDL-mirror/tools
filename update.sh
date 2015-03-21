#!/bin/bash

tools=$(dirname $0)

$tools/pull.sh
$tools/sync-bookmarks.sh
$tools/push.sh
