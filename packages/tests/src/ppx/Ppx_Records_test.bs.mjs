// Generated by ReScript, PLEASE EDIT WITH CARE

import * as U from "../utils/U.bs.mjs";
import Ava from "ava";
import * as S$RescriptStruct from "rescript-struct/src/S.bs.mjs";

var simpleRecordStruct = S$RescriptStruct.$$Object.factory(function (s) {
      return {
              label: s.f("label", S$RescriptStruct.string),
              value: s.f("value", S$RescriptStruct.$$int)
            };
    });

Ava("Simple record struct", (function (t) {
        U.assertEqualStructs(t, simpleRecordStruct, S$RescriptStruct.object(function (s) {
                  return {
                          label: s.f("label", S$RescriptStruct.string),
                          value: s.f("value", S$RescriptStruct.$$int)
                        };
                }), undefined, undefined);
        t.deepEqual(S$RescriptStruct.parseWith({label:"foo",value:1}, simpleRecordStruct), {
              TAG: "Ok",
              _0: {
                label: "foo",
                value: 1
              }
            }, undefined);
      }));

var recordWithAliasStruct = S$RescriptStruct.$$Object.factory(function (s) {
      return {
              label: s.f("aliased-label", S$RescriptStruct.string),
              value: s.f("value", S$RescriptStruct.$$int)
            };
    });

Ava("Record struct with alias for field name", (function (t) {
        U.assertEqualStructs(t, recordWithAliasStruct, S$RescriptStruct.object(function (s) {
                  return {
                          label: s.f("aliased-label", S$RescriptStruct.string),
                          value: s.f("value", S$RescriptStruct.$$int)
                        };
                }), undefined, undefined);
        t.deepEqual(S$RescriptStruct.parseWith({"aliased-label":"foo",value:1}, recordWithAliasStruct), {
              TAG: "Ok",
              _0: {
                label: "foo",
                value: 1
              }
            }, undefined);
      }));

var recordWithOptionalStruct = S$RescriptStruct.$$Object.factory(function (s) {
      return {
              label: s.f("label", S$RescriptStruct.option(S$RescriptStruct.string)),
              value: s.f("value", S$RescriptStruct.option(S$RescriptStruct.$$int))
            };
    });

Ava("Record struct with optional fields", (function (t) {
        U.assertEqualStructs(t, recordWithOptionalStruct, S$RescriptStruct.object(function (s) {
                  return {
                          label: s.f("label", S$RescriptStruct.option(S$RescriptStruct.string)),
                          value: s.f("value", S$RescriptStruct.option(S$RescriptStruct.$$int))
                        };
                }), undefined, undefined);
        t.deepEqual(S$RescriptStruct.parseWith({"label":"foo",value:1}, recordWithOptionalStruct), {
              TAG: "Ok",
              _0: {
                label: "foo",
                value: 1
              }
            }, undefined);
        t.deepEqual(S$RescriptStruct.parseWith({}, recordWithOptionalStruct), {
              TAG: "Ok",
              _0: {
                label: undefined,
                value: undefined
              }
            }, undefined);
      }));

export {
  simpleRecordStruct ,
  recordWithAliasStruct ,
  recordWithOptionalStruct ,
}
/* simpleRecordStruct Not a pure module */
