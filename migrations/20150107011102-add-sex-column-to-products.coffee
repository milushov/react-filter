"use strict"
module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn('Products', 'sex', DataTypes.BOOLEAN).done done

  down: (migration, DataTypes, done) ->
    migration.removeColumn('Products', 'sex').done done