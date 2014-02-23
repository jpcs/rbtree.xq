xquery version "3.0";

(:
 : Copyright (c) 2010-2014 John Snelson
 :
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 :     http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :)

import module namespace rbtree = "http://snelson.org.uk/functions/rbtree" at "../rbtree.xq";
import module namespace compat = "http://snelson.org.uk/functions/xq30-compat" at "compat.xq";

let $lt := function($a, $b) { $a < $b }
let $contains := rbtree:contains($lt, ?, ?)
let $find_gte := rbtree:find_gte($lt, ?, ?)
let $tree := compat:fold-left(
  (
    "aardvark",
    "zebra",
    "elephant",
    "eagle",
    "osterich",
    "terrapin",
    "antelope"
  ),
  rbtree:create(),
  rbtree:insert($lt, ?, ?))
let $tree2 := rbtree:delete($lt, $tree, "osterich")
return (
  $contains($tree, "terrapin"),
  $contains($tree, "aardvark"),
  $contains($tree, "antelope"),

  $contains($tree, "newt"),
  $find_gte($tree, "newt"),

  $contains($tree, "osterich"),
  $contains($tree2, "osterich"),

  "tree:",
  rbtree:fold(function($a, $m) { $a, $m }, (), $tree),

  "tree2:",
  rbtree:fold(function($a, $m) { $a, $m }, (), $tree2)
)
