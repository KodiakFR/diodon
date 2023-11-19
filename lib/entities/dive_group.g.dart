// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dive_group.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDiveGroupCollection on Isar {
  IsarCollection<DiveGroup> get diveGroups => this.collection();
}

const DiveGroupSchema = CollectionSchema(
  name: r'DiveGroup',
  id: -622129528304049927,
  properties: {
    r'divingStop': PropertySchema(
      id: 0,
      name: r'divingStop',
      type: IsarType.string,
    ),
    r'dpDeep': PropertySchema(
      id: 1,
      name: r'dpDeep',
      type: IsarType.string,
    ),
    r'dpTime': PropertySchema(
      id: 2,
      name: r'dpTime',
      type: IsarType.string,
    ),
    r'hourImmersion': PropertySchema(
      id: 3,
      name: r'hourImmersion',
      type: IsarType.dateTime,
    ),
    r'realDeep': PropertySchema(
      id: 4,
      name: r'realDeep',
      type: IsarType.string,
    ),
    r'realTime': PropertySchema(
      id: 5,
      name: r'realTime',
      type: IsarType.string,
    ),
    r'riseHour': PropertySchema(
      id: 6,
      name: r'riseHour',
      type: IsarType.dateTime,
    ),
    r'standAlone': PropertySchema(
      id: 7,
      name: r'standAlone',
      type: IsarType.bool,
    ),
    r'supervised': PropertySchema(
      id: 8,
      name: r'supervised',
      type: IsarType.bool,
    ),
    r'title': PropertySchema(
      id: 9,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _diveGroupEstimateSize,
  serialize: _diveGroupSerialize,
  deserialize: _diveGroupDeserialize,
  deserializeProp: _diveGroupDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'participants': LinkSchema(
      id: -8791196369415823650,
      name: r'participants',
      target: r'Participant',
      single: false,
      linkName: r'diveGroups',
    ),
    r'dive': LinkSchema(
      id: -1015094722195213101,
      name: r'dive',
      target: r'Dive',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _diveGroupGetId,
  getLinks: _diveGroupGetLinks,
  attach: _diveGroupAttach,
  version: '3.1.0+1',
);

int _diveGroupEstimateSize(
  DiveGroup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.divingStop;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.dpDeep;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.dpTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.realDeep;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.realTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _diveGroupSerialize(
  DiveGroup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.divingStop);
  writer.writeString(offsets[1], object.dpDeep);
  writer.writeString(offsets[2], object.dpTime);
  writer.writeDateTime(offsets[3], object.hourImmersion);
  writer.writeString(offsets[4], object.realDeep);
  writer.writeString(offsets[5], object.realTime);
  writer.writeDateTime(offsets[6], object.riseHour);
  writer.writeBool(offsets[7], object.standAlone);
  writer.writeBool(offsets[8], object.supervised);
  writer.writeString(offsets[9], object.title);
}

DiveGroup _diveGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DiveGroup();
  object.divingStop = reader.readStringOrNull(offsets[0]);
  object.dpDeep = reader.readStringOrNull(offsets[1]);
  object.dpTime = reader.readStringOrNull(offsets[2]);
  object.hourImmersion = reader.readDateTimeOrNull(offsets[3]);
  object.id = id;
  object.realDeep = reader.readStringOrNull(offsets[4]);
  object.realTime = reader.readStringOrNull(offsets[5]);
  object.riseHour = reader.readDateTimeOrNull(offsets[6]);
  object.standAlone = reader.readBoolOrNull(offsets[7]);
  object.supervised = reader.readBoolOrNull(offsets[8]);
  object.title = reader.readStringOrNull(offsets[9]);
  return object;
}

P _diveGroupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _diveGroupGetId(DiveGroup object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _diveGroupGetLinks(DiveGroup object) {
  return [object.participants, object.dive];
}

void _diveGroupAttach(IsarCollection<dynamic> col, Id id, DiveGroup object) {
  object.id = id;
  object.participants
      .attach(col, col.isar.collection<Participant>(), r'participants', id);
  object.dive.attach(col, col.isar.collection<Dive>(), r'dive', id);
}

extension DiveGroupQueryWhereSort
    on QueryBuilder<DiveGroup, DiveGroup, QWhere> {
  QueryBuilder<DiveGroup, DiveGroup, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DiveGroupQueryWhere
    on QueryBuilder<DiveGroup, DiveGroup, QWhereClause> {
  QueryBuilder<DiveGroup, DiveGroup, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DiveGroupQueryFilter
    on QueryBuilder<DiveGroup, DiveGroup, QFilterCondition> {
  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> divingStopIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'divingStop',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      divingStopIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'divingStop',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> divingStopEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divingStop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      divingStopGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'divingStop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> divingStopLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'divingStop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> divingStopBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'divingStop',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      divingStopStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'divingStop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> divingStopEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'divingStop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> divingStopContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'divingStop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> divingStopMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'divingStop',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      divingStopIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divingStop',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      divingStopIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'divingStop',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dpDeep',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dpDeep',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dpDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dpDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dpDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dpDeep',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dpDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dpDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dpDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dpDeep',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dpDeep',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpDeepIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dpDeep',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dpTime',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dpTime',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dpTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dpTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dpTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dpTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dpTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dpTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dpTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dpTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dpTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dpTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dpTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      hourImmersionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hourImmersion',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      hourImmersionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hourImmersion',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      hourImmersionEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hourImmersion',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      hourImmersionGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hourImmersion',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      hourImmersionLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hourImmersion',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      hourImmersionBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hourImmersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realDeepIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'realDeep',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      realDeepIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'realDeep',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realDeepEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'realDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realDeepGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'realDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realDeepLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'realDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realDeepBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'realDeep',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realDeepStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'realDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realDeepEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'realDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realDeepContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'realDeep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realDeepMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'realDeep',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realDeepIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'realDeep',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      realDeepIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'realDeep',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'realTime',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      realTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'realTime',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'realTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'realTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'realTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'realTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'realTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'realTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'realTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'realTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> realTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'realTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      realTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'realTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> riseHourIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'riseHour',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      riseHourIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'riseHour',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> riseHourEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'riseHour',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> riseHourGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'riseHour',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> riseHourLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'riseHour',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> riseHourBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'riseHour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> standAloneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'standAlone',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      standAloneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'standAlone',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> standAloneEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'standAlone',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> supervisedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'supervised',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      supervisedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'supervised',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> supervisedEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supervised',
        value: value,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension DiveGroupQueryObject
    on QueryBuilder<DiveGroup, DiveGroup, QFilterCondition> {}

extension DiveGroupQueryLinks
    on QueryBuilder<DiveGroup, DiveGroup, QFilterCondition> {
  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> participants(
      FilterQuery<Participant> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'participants');
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      participantsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'participants', length, true, length, true);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      participantsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'participants', 0, true, 0, true);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      participantsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'participants', 0, false, 999999, true);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      participantsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'participants', 0, true, length, include);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      participantsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'participants', length, include, 999999, true);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition>
      participantsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'participants', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> dive(
      FilterQuery<Dive> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'dive');
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterFilterCondition> diveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'dive', 0, true, 0, true);
    });
  }
}

extension DiveGroupQuerySortBy on QueryBuilder<DiveGroup, DiveGroup, QSortBy> {
  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByDivingStop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divingStop', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByDivingStopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divingStop', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByDpDeep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpDeep', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByDpDeepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpDeep', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByDpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpTime', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByDpTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpTime', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByHourImmersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourImmersion', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByHourImmersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourImmersion', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByRealDeep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realDeep', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByRealDeepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realDeep', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByRealTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realTime', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByRealTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realTime', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByRiseHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riseHour', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByRiseHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riseHour', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByStandAlone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'standAlone', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByStandAloneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'standAlone', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortBySupervised() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supervised', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortBySupervisedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supervised', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension DiveGroupQuerySortThenBy
    on QueryBuilder<DiveGroup, DiveGroup, QSortThenBy> {
  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByDivingStop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divingStop', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByDivingStopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divingStop', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByDpDeep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpDeep', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByDpDeepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpDeep', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByDpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpTime', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByDpTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpTime', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByHourImmersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourImmersion', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByHourImmersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourImmersion', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByRealDeep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realDeep', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByRealDeepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realDeep', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByRealTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realTime', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByRealTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realTime', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByRiseHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riseHour', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByRiseHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riseHour', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByStandAlone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'standAlone', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByStandAloneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'standAlone', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenBySupervised() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supervised', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenBySupervisedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supervised', Sort.desc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension DiveGroupQueryWhereDistinct
    on QueryBuilder<DiveGroup, DiveGroup, QDistinct> {
  QueryBuilder<DiveGroup, DiveGroup, QDistinct> distinctByDivingStop(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'divingStop', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QDistinct> distinctByDpDeep(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dpDeep', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QDistinct> distinctByDpTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dpTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QDistinct> distinctByHourImmersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hourImmersion');
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QDistinct> distinctByRealDeep(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'realDeep', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QDistinct> distinctByRealTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'realTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QDistinct> distinctByRiseHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'riseHour');
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QDistinct> distinctByStandAlone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'standAlone');
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QDistinct> distinctBySupervised() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supervised');
    });
  }

  QueryBuilder<DiveGroup, DiveGroup, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension DiveGroupQueryProperty
    on QueryBuilder<DiveGroup, DiveGroup, QQueryProperty> {
  QueryBuilder<DiveGroup, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DiveGroup, String?, QQueryOperations> divingStopProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'divingStop');
    });
  }

  QueryBuilder<DiveGroup, String?, QQueryOperations> dpDeepProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dpDeep');
    });
  }

  QueryBuilder<DiveGroup, String?, QQueryOperations> dpTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dpTime');
    });
  }

  QueryBuilder<DiveGroup, DateTime?, QQueryOperations> hourImmersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hourImmersion');
    });
  }

  QueryBuilder<DiveGroup, String?, QQueryOperations> realDeepProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'realDeep');
    });
  }

  QueryBuilder<DiveGroup, String?, QQueryOperations> realTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'realTime');
    });
  }

  QueryBuilder<DiveGroup, DateTime?, QQueryOperations> riseHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'riseHour');
    });
  }

  QueryBuilder<DiveGroup, bool?, QQueryOperations> standAloneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'standAlone');
    });
  }

  QueryBuilder<DiveGroup, bool?, QQueryOperations> supervisedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supervised');
    });
  }

  QueryBuilder<DiveGroup, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
