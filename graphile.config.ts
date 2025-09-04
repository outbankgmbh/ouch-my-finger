import "graphile-config";

import { makePgService } from "@dataplan/pg/adaptors/pg";
import { makeV4Preset } from "postgraphile/presets/v4";
import { PostGraphileAmberPreset } from "postgraphile/presets/amber";
import { PgSimplifyInflectionPreset } from "@graphile/simplify-inflection";
import { PgAggregatesPreset } from "@graphile/pg-aggregates";
import { PostGraphileConnectionFilterPreset } from "postgraphile-plugin-connection-filter";
import { PgManyToManyPreset } from "@graphile-contrib/pg-many-to-many";

const isDevelopment = true;
const preset: GraphileConfig.Preset = {
  extends: [
    PostGraphileAmberPreset,
    PgSimplifyInflectionPreset,
    PgAggregatesPreset,
    PgManyToManyPreset,
    PostGraphileConnectionFilterPreset,
    makeV4Preset({
      bodySizeLimit: 100 * 1024 * 1024,
      subscriptions: false,
      retryOnInitFail: true,
      dynamicJson: true,
      watchPg: isDevelopment,
      setofFunctionsContainNulls: false,
      ignoreRBAC: false,
      ignoreIndexes: false,
      graphiql: isDevelopment,
      showErrorStack: isDevelopment ? "json" : false,
      extendedErrors: isDevelopment
        ? ["hint", "detail", "errcode"]
        : ["errcode"],
      enhanceGraphiql: isDevelopment,
      allowExplain: true,
    }),
  ],
  pgServices: [
    makePgService({
      connectionString: process.env.DATABASE_URL,
      schemas: ["public"],
    }),
  ],
};

export default preset;
