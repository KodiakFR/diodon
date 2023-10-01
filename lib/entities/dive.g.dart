// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dive.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDiveCollection on Isar {
  IsarCollection<Dive> get dives => this.collection();
}

const DiveSchema = CollectionSchema(
  name: r'Dive',
  id: 969516474967291219,
  properties: {
    r'boat': PropertySchema(
      id: 0,
      name: r'boat',
      type: IsarType.string,
    ),
    r'captain': PropertySchema(
      id: 1,
      name: r'captain',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 2,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'divingSite': PropertySchema(
      id: 3,
      name: r'divingSite',
      type: IsarType.string,
    ),
    r'dp': PropertySchema(
      id: 4,
      name: r'dp',
      type: IsarType.string,
    ),
    r'hourDepart': PropertySchema(
      id: 5,
      name: r'hourDepart',
      type: IsarType.dateTime,
    ),
    r'nbDiver': PropertySchema(
      id: 6,
      name: r'nbDiver',
      type: IsarType.long,
    ),
    r'nbPeople': PropertySchema(
      id: 7,
      name: r'nbPeople',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 8,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _diveEstimateSize,
  serialize: _diveSerialize,
  deserialize: _diveDeserialize,
  deserializeProp: _diveDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'divreGroups': LinkSchema(
      id: -3927974159904947061,
      name: r'divreGroups',
      target: r'DiveGroup',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _diveGetId,
  getLinks: _diveGetLinks,
  attach: _diveAttach,
  version: '3.1.0+1',
);

int _diveEstimateSize(
  Dive object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.boat.length * 3;
  bytesCount += 3 + object.captain.length * 3;
  bytesCount += 3 + object.divingSite.length * 3;
  bytesCount += 3 + object.dp.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _diveSerialize(
  Dive object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.boat);
  writer.writeString(offsets[1], object.captain);
  writer.writeDateTime(offsets[2], object.date);
  writer.writeString(offsets[3], object.divingSite);
  writer.writeString(offsets[4], object.dp);
  writer.writeDateTime(offsets[5], object.hourDepart);
  writer.writeLong(offsets[6], object.nbDiver);
  writer.writeLong(offsets[7], object.nbPeople);
  writer.writeString(offsets[8], object.title);
}

Dive _diveDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Dive();
  object.boat = reader.readString(offsets[0]);
  object.captain = reader.readString(offsets[1]);
  object.date = reader.readDateTime(offsets[2]);
  object.divingSite = reader.readString(offsets[3]);
  object.dp = reader.readString(offsets[4]);
  object.hourDepart = reader.readDateTime(offsets[5]);
  object.id = id;
  object.nbDiver = reader.readLong(offsets[6]);
  object.nbPeople = reader.readLong(offsets[7]);
  object.title = reader.readString(offsets[8]);
  return object;
}

P _diveDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _diveGetId(Dive object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _diveGetLinks(Dive object) {
  return [object.divreGroups];
}

void _diveAttach(IsarCollection<dynamic> col, Id id, Dive object) {
  object.id = id;
  object.divreGroups
      .attach(col, col.isar.collection<DiveGroup>(), r'divreGroups', id);
}

extension DiveQueryWhereSort on QueryBuilder<Dive, Dive, QWhere> {
  QueryBuilder<Dive, Dive, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DiveQueryWhere on QueryBuilder<Dive, Dive, QWhereClause> {
  QueryBuilder<Dive, Dive, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Dive, Dive, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Dive, Dive, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Dive, Dive, QAfterWhereClause> idBetween(
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

extension DiveQueryFilter on QueryBuilder<Dive, Dive, QFilterCondition> {
  QueryBuilder<Dive, Dive, QAfterFilterCondition> boatEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> boatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> boatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> boatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> boatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'boat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> boatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'boat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> boatContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> boatMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boat',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> boatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boat',
        value: '',
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> boatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boat',
        value: '',
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> captainEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'captain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> captainGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'captain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> captainLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'captain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> captainBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'captain',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> captainStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'captain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> captainEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'captain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> captainContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'captain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> captainMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'captain',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> captainIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'captain',
        value: '',
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> captainIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'captain',
        value: '',
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divingSiteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divingSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divingSiteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'divingSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divingSiteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'divingSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divingSiteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'divingSite',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divingSiteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'divingSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divingSiteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'divingSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divingSiteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'divingSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divingSiteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'divingSite',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divingSiteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divingSite',
        value: '',
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divingSiteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'divingSite',
        value: '',
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dpEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dpGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dpLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dpBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dpContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dpMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dpIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dp',
        value: '',
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> dpIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dp',
        value: '',
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> hourDepartEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hourDepart',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> hourDepartGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hourDepart',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> hourDepartLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hourDepart',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> hourDepartBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hourDepart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Dive, Dive, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Dive, Dive, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Dive, Dive, QAfterFilterCondition> nbDiverEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nbDiver',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> nbDiverGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nbDiver',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> nbDiverLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nbDiver',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> nbDiverBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nbDiver',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> nbPeopleEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nbPeople',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> nbPeopleGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nbPeople',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> nbPeopleLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nbPeople',
        value: value,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> nbPeopleBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nbPeople',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> titleEqualTo(
    String value, {
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

  QueryBuilder<Dive, Dive, QAfterFilterCondition> titleGreaterThan(
    String value, {
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

  QueryBuilder<Dive, Dive, QAfterFilterCondition> titleLessThan(
    String value, {
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

  QueryBuilder<Dive, Dive, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
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

  QueryBuilder<Dive, Dive, QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<Dive, Dive, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<Dive, Dive, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension DiveQueryObject on QueryBuilder<Dive, Dive, QFilterCondition> {}

extension DiveQueryLinks on QueryBuilder<Dive, Dive, QFilterCondition> {
  QueryBuilder<Dive, Dive, QAfterFilterCondition> divreGroups(
      FilterQuery<DiveGroup> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'divreGroups');
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divreGroupsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'divreGroups', length, true, length, true);
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divreGroupsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'divreGroups', 0, true, 0, true);
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divreGroupsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'divreGroups', 0, false, 999999, true);
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divreGroupsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'divreGroups', 0, true, length, include);
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divreGroupsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'divreGroups', length, include, 999999, true);
    });
  }

  QueryBuilder<Dive, Dive, QAfterFilterCondition> divreGroupsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'divreGroups', lower, includeLower, upper, includeUpper);
    });
  }
}

extension DiveQuerySortBy on QueryBuilder<Dive, Dive, QSortBy> {
  QueryBuilder<Dive, Dive, QAfterSortBy> sortByBoat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boat', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByBoatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boat', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByCaptain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'captain', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByCaptainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'captain', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByDivingSite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divingSite', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByDivingSiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divingSite', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByDp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dp', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByDpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dp', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByHourDepart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourDepart', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByHourDepartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourDepart', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByNbDiver() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nbDiver', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByNbDiverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nbDiver', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByNbPeople() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nbPeople', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByNbPeopleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nbPeople', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension DiveQuerySortThenBy on QueryBuilder<Dive, Dive, QSortThenBy> {
  QueryBuilder<Dive, Dive, QAfterSortBy> thenByBoat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boat', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByBoatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boat', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByCaptain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'captain', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByCaptainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'captain', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByDivingSite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divingSite', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByDivingSiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divingSite', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByDp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dp', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByDpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dp', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByHourDepart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourDepart', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByHourDepartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourDepart', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByNbDiver() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nbDiver', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByNbDiverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nbDiver', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByNbPeople() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nbPeople', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByNbPeopleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nbPeople', Sort.desc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Dive, Dive, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension DiveQueryWhereDistinct on QueryBuilder<Dive, Dive, QDistinct> {
  QueryBuilder<Dive, Dive, QDistinct> distinctByBoat(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boat', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dive, Dive, QDistinct> distinctByCaptain(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'captain', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dive, Dive, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<Dive, Dive, QDistinct> distinctByDivingSite(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'divingSite', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dive, Dive, QDistinct> distinctByDp(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dp', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dive, Dive, QDistinct> distinctByHourDepart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hourDepart');
    });
  }

  QueryBuilder<Dive, Dive, QDistinct> distinctByNbDiver() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nbDiver');
    });
  }

  QueryBuilder<Dive, Dive, QDistinct> distinctByNbPeople() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nbPeople');
    });
  }

  QueryBuilder<Dive, Dive, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension DiveQueryProperty on QueryBuilder<Dive, Dive, QQueryProperty> {
  QueryBuilder<Dive, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Dive, String, QQueryOperations> boatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boat');
    });
  }

  QueryBuilder<Dive, String, QQueryOperations> captainProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'captain');
    });
  }

  QueryBuilder<Dive, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<Dive, String, QQueryOperations> divingSiteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'divingSite');
    });
  }

  QueryBuilder<Dive, String, QQueryOperations> dpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dp');
    });
  }

  QueryBuilder<Dive, DateTime, QQueryOperations> hourDepartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hourDepart');
    });
  }

  QueryBuilder<Dive, int, QQueryOperations> nbDiverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nbDiver');
    });
  }

  QueryBuilder<Dive, int, QQueryOperations> nbPeopleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nbPeople');
    });
  }

  QueryBuilder<Dive, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
