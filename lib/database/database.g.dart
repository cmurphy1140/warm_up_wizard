// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MovesTable extends Moves with TableInfo<$MovesTable, Move> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradeMinMeta = const VerificationMeta(
    'gradeMin',
  );
  @override
  late final GeneratedColumn<int> gradeMin = GeneratedColumn<int>(
    'grade_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradeMaxMeta = const VerificationMeta(
    'gradeMax',
  );
  @override
  late final GeneratedColumn<int> gradeMax = GeneratedColumn<int>(
    'grade_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SpaceType, int> needsSpace =
      GeneratedColumn<int>(
        'needs_space',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SpaceType>($MovesTable.$converterneedsSpace);
  static const VerificationMeta _needsEquipmentMeta = const VerificationMeta(
    'needsEquipment',
  );
  @override
  late final GeneratedColumn<String> needsEquipment = GeneratedColumn<String>(
    'needs_equipment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ImpactLevel, int> impact =
      GeneratedColumn<int>(
        'impact',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ImpactLevel>($MovesTable.$converterimpact);
  @override
  late final GeneratedColumnWithTypeConverter<NoiseLevel, int> noise =
      GeneratedColumn<int>(
        'noise',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<NoiseLevel>($MovesTable.$converternoise);
  static const VerificationMeta _allowFloorMeta = const VerificationMeta(
    'allowFloor',
  );
  @override
  late final GeneratedColumn<bool> allowFloor = GeneratedColumn<bool>(
    'allow_floor',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("allow_floor" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _defaultDurationSMeta = const VerificationMeta(
    'defaultDurationS',
  );
  @override
  late final GeneratedColumn<int> defaultDurationS = GeneratedColumn<int>(
    'default_duration_s',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _keyframesMeta = const VerificationMeta(
    'keyframes',
  );
  @override
  late final GeneratedColumn<String> keyframes = GeneratedColumn<String>(
    'keyframes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lottieAssetPathMeta = const VerificationMeta(
    'lottieAssetPath',
  );
  @override
  late final GeneratedColumn<String> lottieAssetPath = GeneratedColumn<String>(
    'lottie_asset_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    tags,
    gradeMin,
    gradeMax,
    needsSpace,
    needsEquipment,
    impact,
    noise,
    allowFloor,
    defaultDurationS,
    keyframes,
    lottieAssetPath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'moves';
  @override
  VerificationContext validateIntegrity(
    Insertable<Move> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('grade_min')) {
      context.handle(
        _gradeMinMeta,
        gradeMin.isAcceptableOrUnknown(data['grade_min']!, _gradeMinMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMinMeta);
    }
    if (data.containsKey('grade_max')) {
      context.handle(
        _gradeMaxMeta,
        gradeMax.isAcceptableOrUnknown(data['grade_max']!, _gradeMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMaxMeta);
    }
    if (data.containsKey('needs_equipment')) {
      context.handle(
        _needsEquipmentMeta,
        needsEquipment.isAcceptableOrUnknown(
          data['needs_equipment']!,
          _needsEquipmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_needsEquipmentMeta);
    }
    if (data.containsKey('allow_floor')) {
      context.handle(
        _allowFloorMeta,
        allowFloor.isAcceptableOrUnknown(data['allow_floor']!, _allowFloorMeta),
      );
    }
    if (data.containsKey('default_duration_s')) {
      context.handle(
        _defaultDurationSMeta,
        defaultDurationS.isAcceptableOrUnknown(
          data['default_duration_s']!,
          _defaultDurationSMeta,
        ),
      );
    }
    if (data.containsKey('keyframes')) {
      context.handle(
        _keyframesMeta,
        keyframes.isAcceptableOrUnknown(data['keyframes']!, _keyframesMeta),
      );
    }
    if (data.containsKey('lottie_asset_path')) {
      context.handle(
        _lottieAssetPathMeta,
        lottieAssetPath.isAcceptableOrUnknown(
          data['lottie_asset_path']!,
          _lottieAssetPathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Move map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Move(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      gradeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grade_min'],
      )!,
      gradeMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grade_max'],
      )!,
      needsSpace: $MovesTable.$converterneedsSpace.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}needs_space'],
        )!,
      ),
      needsEquipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}needs_equipment'],
      )!,
      impact: $MovesTable.$converterimpact.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}impact'],
        )!,
      ),
      noise: $MovesTable.$converternoise.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}noise'],
        )!,
      ),
      allowFloor: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}allow_floor'],
      )!,
      defaultDurationS: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_duration_s'],
      )!,
      keyframes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keyframes'],
      ),
      lottieAssetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lottie_asset_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MovesTable createAlias(String alias) {
    return $MovesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SpaceType, int, int> $converterneedsSpace =
      const EnumIndexConverter<SpaceType>(SpaceType.values);
  static JsonTypeConverter2<ImpactLevel, int, int> $converterimpact =
      const EnumIndexConverter<ImpactLevel>(ImpactLevel.values);
  static JsonTypeConverter2<NoiseLevel, int, int> $converternoise =
      const EnumIndexConverter<NoiseLevel>(NoiseLevel.values);
}

class Move extends DataClass implements Insertable<Move> {
  final int id;
  final String name;
  final String tags;
  final int gradeMin;
  final int gradeMax;
  final SpaceType needsSpace;
  final String needsEquipment;
  final ImpactLevel impact;
  final NoiseLevel noise;
  final bool allowFloor;
  final int defaultDurationS;
  final String? keyframes;
  final String? lottieAssetPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Move({
    required this.id,
    required this.name,
    required this.tags,
    required this.gradeMin,
    required this.gradeMax,
    required this.needsSpace,
    required this.needsEquipment,
    required this.impact,
    required this.noise,
    required this.allowFloor,
    required this.defaultDurationS,
    this.keyframes,
    this.lottieAssetPath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['tags'] = Variable<String>(tags);
    map['grade_min'] = Variable<int>(gradeMin);
    map['grade_max'] = Variable<int>(gradeMax);
    {
      map['needs_space'] = Variable<int>(
        $MovesTable.$converterneedsSpace.toSql(needsSpace),
      );
    }
    map['needs_equipment'] = Variable<String>(needsEquipment);
    {
      map['impact'] = Variable<int>($MovesTable.$converterimpact.toSql(impact));
    }
    {
      map['noise'] = Variable<int>($MovesTable.$converternoise.toSql(noise));
    }
    map['allow_floor'] = Variable<bool>(allowFloor);
    map['default_duration_s'] = Variable<int>(defaultDurationS);
    if (!nullToAbsent || keyframes != null) {
      map['keyframes'] = Variable<String>(keyframes);
    }
    if (!nullToAbsent || lottieAssetPath != null) {
      map['lottie_asset_path'] = Variable<String>(lottieAssetPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MovesCompanion toCompanion(bool nullToAbsent) {
    return MovesCompanion(
      id: Value(id),
      name: Value(name),
      tags: Value(tags),
      gradeMin: Value(gradeMin),
      gradeMax: Value(gradeMax),
      needsSpace: Value(needsSpace),
      needsEquipment: Value(needsEquipment),
      impact: Value(impact),
      noise: Value(noise),
      allowFloor: Value(allowFloor),
      defaultDurationS: Value(defaultDurationS),
      keyframes: keyframes == null && nullToAbsent
          ? const Value.absent()
          : Value(keyframes),
      lottieAssetPath: lottieAssetPath == null && nullToAbsent
          ? const Value.absent()
          : Value(lottieAssetPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Move.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Move(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      tags: serializer.fromJson<String>(json['tags']),
      gradeMin: serializer.fromJson<int>(json['gradeMin']),
      gradeMax: serializer.fromJson<int>(json['gradeMax']),
      needsSpace: $MovesTable.$converterneedsSpace.fromJson(
        serializer.fromJson<int>(json['needsSpace']),
      ),
      needsEquipment: serializer.fromJson<String>(json['needsEquipment']),
      impact: $MovesTable.$converterimpact.fromJson(
        serializer.fromJson<int>(json['impact']),
      ),
      noise: $MovesTable.$converternoise.fromJson(
        serializer.fromJson<int>(json['noise']),
      ),
      allowFloor: serializer.fromJson<bool>(json['allowFloor']),
      defaultDurationS: serializer.fromJson<int>(json['defaultDurationS']),
      keyframes: serializer.fromJson<String?>(json['keyframes']),
      lottieAssetPath: serializer.fromJson<String?>(json['lottieAssetPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'tags': serializer.toJson<String>(tags),
      'gradeMin': serializer.toJson<int>(gradeMin),
      'gradeMax': serializer.toJson<int>(gradeMax),
      'needsSpace': serializer.toJson<int>(
        $MovesTable.$converterneedsSpace.toJson(needsSpace),
      ),
      'needsEquipment': serializer.toJson<String>(needsEquipment),
      'impact': serializer.toJson<int>(
        $MovesTable.$converterimpact.toJson(impact),
      ),
      'noise': serializer.toJson<int>(
        $MovesTable.$converternoise.toJson(noise),
      ),
      'allowFloor': serializer.toJson<bool>(allowFloor),
      'defaultDurationS': serializer.toJson<int>(defaultDurationS),
      'keyframes': serializer.toJson<String?>(keyframes),
      'lottieAssetPath': serializer.toJson<String?>(lottieAssetPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Move copyWith({
    int? id,
    String? name,
    String? tags,
    int? gradeMin,
    int? gradeMax,
    SpaceType? needsSpace,
    String? needsEquipment,
    ImpactLevel? impact,
    NoiseLevel? noise,
    bool? allowFloor,
    int? defaultDurationS,
    Value<String?> keyframes = const Value.absent(),
    Value<String?> lottieAssetPath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Move(
    id: id ?? this.id,
    name: name ?? this.name,
    tags: tags ?? this.tags,
    gradeMin: gradeMin ?? this.gradeMin,
    gradeMax: gradeMax ?? this.gradeMax,
    needsSpace: needsSpace ?? this.needsSpace,
    needsEquipment: needsEquipment ?? this.needsEquipment,
    impact: impact ?? this.impact,
    noise: noise ?? this.noise,
    allowFloor: allowFloor ?? this.allowFloor,
    defaultDurationS: defaultDurationS ?? this.defaultDurationS,
    keyframes: keyframes.present ? keyframes.value : this.keyframes,
    lottieAssetPath: lottieAssetPath.present
        ? lottieAssetPath.value
        : this.lottieAssetPath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Move copyWithCompanion(MovesCompanion data) {
    return Move(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      tags: data.tags.present ? data.tags.value : this.tags,
      gradeMin: data.gradeMin.present ? data.gradeMin.value : this.gradeMin,
      gradeMax: data.gradeMax.present ? data.gradeMax.value : this.gradeMax,
      needsSpace: data.needsSpace.present
          ? data.needsSpace.value
          : this.needsSpace,
      needsEquipment: data.needsEquipment.present
          ? data.needsEquipment.value
          : this.needsEquipment,
      impact: data.impact.present ? data.impact.value : this.impact,
      noise: data.noise.present ? data.noise.value : this.noise,
      allowFloor: data.allowFloor.present
          ? data.allowFloor.value
          : this.allowFloor,
      defaultDurationS: data.defaultDurationS.present
          ? data.defaultDurationS.value
          : this.defaultDurationS,
      keyframes: data.keyframes.present ? data.keyframes.value : this.keyframes,
      lottieAssetPath: data.lottieAssetPath.present
          ? data.lottieAssetPath.value
          : this.lottieAssetPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Move(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tags: $tags, ')
          ..write('gradeMin: $gradeMin, ')
          ..write('gradeMax: $gradeMax, ')
          ..write('needsSpace: $needsSpace, ')
          ..write('needsEquipment: $needsEquipment, ')
          ..write('impact: $impact, ')
          ..write('noise: $noise, ')
          ..write('allowFloor: $allowFloor, ')
          ..write('defaultDurationS: $defaultDurationS, ')
          ..write('keyframes: $keyframes, ')
          ..write('lottieAssetPath: $lottieAssetPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    tags,
    gradeMin,
    gradeMax,
    needsSpace,
    needsEquipment,
    impact,
    noise,
    allowFloor,
    defaultDurationS,
    keyframes,
    lottieAssetPath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Move &&
          other.id == this.id &&
          other.name == this.name &&
          other.tags == this.tags &&
          other.gradeMin == this.gradeMin &&
          other.gradeMax == this.gradeMax &&
          other.needsSpace == this.needsSpace &&
          other.needsEquipment == this.needsEquipment &&
          other.impact == this.impact &&
          other.noise == this.noise &&
          other.allowFloor == this.allowFloor &&
          other.defaultDurationS == this.defaultDurationS &&
          other.keyframes == this.keyframes &&
          other.lottieAssetPath == this.lottieAssetPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MovesCompanion extends UpdateCompanion<Move> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> tags;
  final Value<int> gradeMin;
  final Value<int> gradeMax;
  final Value<SpaceType> needsSpace;
  final Value<String> needsEquipment;
  final Value<ImpactLevel> impact;
  final Value<NoiseLevel> noise;
  final Value<bool> allowFloor;
  final Value<int> defaultDurationS;
  final Value<String?> keyframes;
  final Value<String?> lottieAssetPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MovesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.tags = const Value.absent(),
    this.gradeMin = const Value.absent(),
    this.gradeMax = const Value.absent(),
    this.needsSpace = const Value.absent(),
    this.needsEquipment = const Value.absent(),
    this.impact = const Value.absent(),
    this.noise = const Value.absent(),
    this.allowFloor = const Value.absent(),
    this.defaultDurationS = const Value.absent(),
    this.keyframes = const Value.absent(),
    this.lottieAssetPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MovesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String tags,
    required int gradeMin,
    required int gradeMax,
    required SpaceType needsSpace,
    required String needsEquipment,
    required ImpactLevel impact,
    required NoiseLevel noise,
    this.allowFloor = const Value.absent(),
    this.defaultDurationS = const Value.absent(),
    this.keyframes = const Value.absent(),
    this.lottieAssetPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       tags = Value(tags),
       gradeMin = Value(gradeMin),
       gradeMax = Value(gradeMax),
       needsSpace = Value(needsSpace),
       needsEquipment = Value(needsEquipment),
       impact = Value(impact),
       noise = Value(noise);
  static Insertable<Move> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? tags,
    Expression<int>? gradeMin,
    Expression<int>? gradeMax,
    Expression<int>? needsSpace,
    Expression<String>? needsEquipment,
    Expression<int>? impact,
    Expression<int>? noise,
    Expression<bool>? allowFloor,
    Expression<int>? defaultDurationS,
    Expression<String>? keyframes,
    Expression<String>? lottieAssetPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (tags != null) 'tags': tags,
      if (gradeMin != null) 'grade_min': gradeMin,
      if (gradeMax != null) 'grade_max': gradeMax,
      if (needsSpace != null) 'needs_space': needsSpace,
      if (needsEquipment != null) 'needs_equipment': needsEquipment,
      if (impact != null) 'impact': impact,
      if (noise != null) 'noise': noise,
      if (allowFloor != null) 'allow_floor': allowFloor,
      if (defaultDurationS != null) 'default_duration_s': defaultDurationS,
      if (keyframes != null) 'keyframes': keyframes,
      if (lottieAssetPath != null) 'lottie_asset_path': lottieAssetPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MovesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? tags,
    Value<int>? gradeMin,
    Value<int>? gradeMax,
    Value<SpaceType>? needsSpace,
    Value<String>? needsEquipment,
    Value<ImpactLevel>? impact,
    Value<NoiseLevel>? noise,
    Value<bool>? allowFloor,
    Value<int>? defaultDurationS,
    Value<String?>? keyframes,
    Value<String?>? lottieAssetPath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MovesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      tags: tags ?? this.tags,
      gradeMin: gradeMin ?? this.gradeMin,
      gradeMax: gradeMax ?? this.gradeMax,
      needsSpace: needsSpace ?? this.needsSpace,
      needsEquipment: needsEquipment ?? this.needsEquipment,
      impact: impact ?? this.impact,
      noise: noise ?? this.noise,
      allowFloor: allowFloor ?? this.allowFloor,
      defaultDurationS: defaultDurationS ?? this.defaultDurationS,
      keyframes: keyframes ?? this.keyframes,
      lottieAssetPath: lottieAssetPath ?? this.lottieAssetPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (gradeMin.present) {
      map['grade_min'] = Variable<int>(gradeMin.value);
    }
    if (gradeMax.present) {
      map['grade_max'] = Variable<int>(gradeMax.value);
    }
    if (needsSpace.present) {
      map['needs_space'] = Variable<int>(
        $MovesTable.$converterneedsSpace.toSql(needsSpace.value),
      );
    }
    if (needsEquipment.present) {
      map['needs_equipment'] = Variable<String>(needsEquipment.value);
    }
    if (impact.present) {
      map['impact'] = Variable<int>(
        $MovesTable.$converterimpact.toSql(impact.value),
      );
    }
    if (noise.present) {
      map['noise'] = Variable<int>(
        $MovesTable.$converternoise.toSql(noise.value),
      );
    }
    if (allowFloor.present) {
      map['allow_floor'] = Variable<bool>(allowFloor.value);
    }
    if (defaultDurationS.present) {
      map['default_duration_s'] = Variable<int>(defaultDurationS.value);
    }
    if (keyframes.present) {
      map['keyframes'] = Variable<String>(keyframes.value);
    }
    if (lottieAssetPath.present) {
      map['lottie_asset_path'] = Variable<String>(lottieAssetPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tags: $tags, ')
          ..write('gradeMin: $gradeMin, ')
          ..write('gradeMax: $gradeMax, ')
          ..write('needsSpace: $needsSpace, ')
          ..write('needsEquipment: $needsEquipment, ')
          ..write('impact: $impact, ')
          ..write('noise: $noise, ')
          ..write('allowFloor: $allowFloor, ')
          ..write('defaultDurationS: $defaultDurationS, ')
          ..write('keyframes: $keyframes, ')
          ..write('lottieAssetPath: $lottieAssetPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RoutinesTable extends Routines with TableInfo<$RoutinesTable, Routine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalSecondsMeta = const VerificationMeta(
    'totalSeconds',
  );
  @override
  late final GeneratedColumn<int> totalSeconds = GeneratedColumn<int>(
    'total_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _blocksJsonMeta = const VerificationMeta(
    'blocksJson',
  );
  @override
  late final GeneratedColumn<String> blocksJson = GeneratedColumn<String>(
    'blocks_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    totalSeconds,
    blocksJson,
    isFavorite,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<Routine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('total_seconds')) {
      context.handle(
        _totalSecondsMeta,
        totalSeconds.isAcceptableOrUnknown(
          data['total_seconds']!,
          _totalSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalSecondsMeta);
    }
    if (data.containsKey('blocks_json')) {
      context.handle(
        _blocksJsonMeta,
        blocksJson.isAcceptableOrUnknown(data['blocks_json']!, _blocksJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_blocksJsonMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Routine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Routine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      totalSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_seconds'],
      )!,
      blocksJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blocks_json'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }
}

class Routine extends DataClass implements Insertable<Routine> {
  final int id;
  final String name;
  final int totalSeconds;
  final String blocksJson;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Routine({
    required this.id,
    required this.name,
    required this.totalSeconds,
    required this.blocksJson,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['total_seconds'] = Variable<int>(totalSeconds);
    map['blocks_json'] = Variable<String>(blocksJson);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      name: Value(name),
      totalSeconds: Value(totalSeconds),
      blocksJson: Value(blocksJson),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Routine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Routine(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      totalSeconds: serializer.fromJson<int>(json['totalSeconds']),
      blocksJson: serializer.fromJson<String>(json['blocksJson']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'totalSeconds': serializer.toJson<int>(totalSeconds),
      'blocksJson': serializer.toJson<String>(blocksJson),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Routine copyWith({
    int? id,
    String? name,
    int? totalSeconds,
    String? blocksJson,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Routine(
    id: id ?? this.id,
    name: name ?? this.name,
    totalSeconds: totalSeconds ?? this.totalSeconds,
    blocksJson: blocksJson ?? this.blocksJson,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Routine copyWithCompanion(RoutinesCompanion data) {
    return Routine(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      totalSeconds: data.totalSeconds.present
          ? data.totalSeconds.value
          : this.totalSeconds,
      blocksJson: data.blocksJson.present
          ? data.blocksJson.value
          : this.blocksJson,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Routine(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('totalSeconds: $totalSeconds, ')
          ..write('blocksJson: $blocksJson, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    totalSeconds,
    blocksJson,
    isFavorite,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Routine &&
          other.id == this.id &&
          other.name == this.name &&
          other.totalSeconds == this.totalSeconds &&
          other.blocksJson == this.blocksJson &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RoutinesCompanion extends UpdateCompanion<Routine> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> totalSeconds;
  final Value<String> blocksJson;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.totalSeconds = const Value.absent(),
    this.blocksJson = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RoutinesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int totalSeconds,
    required String blocksJson,
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       totalSeconds = Value(totalSeconds),
       blocksJson = Value(blocksJson);
  static Insertable<Routine> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? totalSeconds,
    Expression<String>? blocksJson,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (totalSeconds != null) 'total_seconds': totalSeconds,
      if (blocksJson != null) 'blocks_json': blocksJson,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RoutinesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? totalSeconds,
    Value<String>? blocksJson,
    Value<bool>? isFavorite,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RoutinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      blocksJson: blocksJson ?? this.blocksJson,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (totalSeconds.present) {
      map['total_seconds'] = Variable<int>(totalSeconds.value);
    }
    if (blocksJson.present) {
      map['blocks_json'] = Variable<String>(blocksJson.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('totalSeconds: $totalSeconds, ')
          ..write('blocksJson: $blocksJson, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PresetsTable extends Presets with TableInfo<$PresetsTable, Preset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PresetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<GradeBand, int> gradeBand =
      GeneratedColumn<int>(
        'grade_band',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<GradeBand>($PresetsTable.$convertergradeBand);
  @override
  late final GeneratedColumnWithTypeConverter<SpaceType, int> space =
      GeneratedColumn<int>(
        'space',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SpaceType>($PresetsTable.$converterspace);
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RoutineType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<RoutineType>($PresetsTable.$convertertype);
  static const VerificationMeta _lengthSMeta = const VerificationMeta(
    'lengthS',
  );
  @override
  late final GeneratedColumn<int> lengthS = GeneratedColumn<int>(
    'length_s',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _constraintsJsonMeta = const VerificationMeta(
    'constraintsJson',
  );
  @override
  late final GeneratedColumn<String> constraintsJson = GeneratedColumn<String>(
    'constraints_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gradeBand,
    space,
    equipment,
    type,
    lengthS,
    constraintsJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'presets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Preset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    } else if (isInserting) {
      context.missing(_equipmentMeta);
    }
    if (data.containsKey('length_s')) {
      context.handle(
        _lengthSMeta,
        lengthS.isAcceptableOrUnknown(data['length_s']!, _lengthSMeta),
      );
    } else if (isInserting) {
      context.missing(_lengthSMeta);
    }
    if (data.containsKey('constraints_json')) {
      context.handle(
        _constraintsJsonMeta,
        constraintsJson.isAcceptableOrUnknown(
          data['constraints_json']!,
          _constraintsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_constraintsJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Preset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Preset(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      gradeBand: $PresetsTable.$convertergradeBand.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}grade_band'],
        )!,
      ),
      space: $PresetsTable.$converterspace.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}space'],
        )!,
      ),
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      )!,
      type: $PresetsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      lengthS: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}length_s'],
      )!,
      constraintsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}constraints_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PresetsTable createAlias(String alias) {
    return $PresetsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GradeBand, int, int> $convertergradeBand =
      const EnumIndexConverter<GradeBand>(GradeBand.values);
  static JsonTypeConverter2<SpaceType, int, int> $converterspace =
      const EnumIndexConverter<SpaceType>(SpaceType.values);
  static JsonTypeConverter2<RoutineType, int, int> $convertertype =
      const EnumIndexConverter<RoutineType>(RoutineType.values);
}

class Preset extends DataClass implements Insertable<Preset> {
  final int id;
  final GradeBand gradeBand;
  final SpaceType space;
  final String equipment;
  final RoutineType type;
  final int lengthS;
  final String constraintsJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Preset({
    required this.id,
    required this.gradeBand,
    required this.space,
    required this.equipment,
    required this.type,
    required this.lengthS,
    required this.constraintsJson,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['grade_band'] = Variable<int>(
        $PresetsTable.$convertergradeBand.toSql(gradeBand),
      );
    }
    {
      map['space'] = Variable<int>($PresetsTable.$converterspace.toSql(space));
    }
    map['equipment'] = Variable<String>(equipment);
    {
      map['type'] = Variable<int>($PresetsTable.$convertertype.toSql(type));
    }
    map['length_s'] = Variable<int>(lengthS);
    map['constraints_json'] = Variable<String>(constraintsJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PresetsCompanion toCompanion(bool nullToAbsent) {
    return PresetsCompanion(
      id: Value(id),
      gradeBand: Value(gradeBand),
      space: Value(space),
      equipment: Value(equipment),
      type: Value(type),
      lengthS: Value(lengthS),
      constraintsJson: Value(constraintsJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Preset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Preset(
      id: serializer.fromJson<int>(json['id']),
      gradeBand: $PresetsTable.$convertergradeBand.fromJson(
        serializer.fromJson<int>(json['gradeBand']),
      ),
      space: $PresetsTable.$converterspace.fromJson(
        serializer.fromJson<int>(json['space']),
      ),
      equipment: serializer.fromJson<String>(json['equipment']),
      type: $PresetsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      lengthS: serializer.fromJson<int>(json['lengthS']),
      constraintsJson: serializer.fromJson<String>(json['constraintsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gradeBand': serializer.toJson<int>(
        $PresetsTable.$convertergradeBand.toJson(gradeBand),
      ),
      'space': serializer.toJson<int>(
        $PresetsTable.$converterspace.toJson(space),
      ),
      'equipment': serializer.toJson<String>(equipment),
      'type': serializer.toJson<int>($PresetsTable.$convertertype.toJson(type)),
      'lengthS': serializer.toJson<int>(lengthS),
      'constraintsJson': serializer.toJson<String>(constraintsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Preset copyWith({
    int? id,
    GradeBand? gradeBand,
    SpaceType? space,
    String? equipment,
    RoutineType? type,
    int? lengthS,
    String? constraintsJson,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Preset(
    id: id ?? this.id,
    gradeBand: gradeBand ?? this.gradeBand,
    space: space ?? this.space,
    equipment: equipment ?? this.equipment,
    type: type ?? this.type,
    lengthS: lengthS ?? this.lengthS,
    constraintsJson: constraintsJson ?? this.constraintsJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Preset copyWithCompanion(PresetsCompanion data) {
    return Preset(
      id: data.id.present ? data.id.value : this.id,
      gradeBand: data.gradeBand.present ? data.gradeBand.value : this.gradeBand,
      space: data.space.present ? data.space.value : this.space,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      type: data.type.present ? data.type.value : this.type,
      lengthS: data.lengthS.present ? data.lengthS.value : this.lengthS,
      constraintsJson: data.constraintsJson.present
          ? data.constraintsJson.value
          : this.constraintsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Preset(')
          ..write('id: $id, ')
          ..write('gradeBand: $gradeBand, ')
          ..write('space: $space, ')
          ..write('equipment: $equipment, ')
          ..write('type: $type, ')
          ..write('lengthS: $lengthS, ')
          ..write('constraintsJson: $constraintsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gradeBand,
    space,
    equipment,
    type,
    lengthS,
    constraintsJson,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Preset &&
          other.id == this.id &&
          other.gradeBand == this.gradeBand &&
          other.space == this.space &&
          other.equipment == this.equipment &&
          other.type == this.type &&
          other.lengthS == this.lengthS &&
          other.constraintsJson == this.constraintsJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PresetsCompanion extends UpdateCompanion<Preset> {
  final Value<int> id;
  final Value<GradeBand> gradeBand;
  final Value<SpaceType> space;
  final Value<String> equipment;
  final Value<RoutineType> type;
  final Value<int> lengthS;
  final Value<String> constraintsJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PresetsCompanion({
    this.id = const Value.absent(),
    this.gradeBand = const Value.absent(),
    this.space = const Value.absent(),
    this.equipment = const Value.absent(),
    this.type = const Value.absent(),
    this.lengthS = const Value.absent(),
    this.constraintsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PresetsCompanion.insert({
    this.id = const Value.absent(),
    required GradeBand gradeBand,
    required SpaceType space,
    required String equipment,
    required RoutineType type,
    required int lengthS,
    required String constraintsJson,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : gradeBand = Value(gradeBand),
       space = Value(space),
       equipment = Value(equipment),
       type = Value(type),
       lengthS = Value(lengthS),
       constraintsJson = Value(constraintsJson);
  static Insertable<Preset> custom({
    Expression<int>? id,
    Expression<int>? gradeBand,
    Expression<int>? space,
    Expression<String>? equipment,
    Expression<int>? type,
    Expression<int>? lengthS,
    Expression<String>? constraintsJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gradeBand != null) 'grade_band': gradeBand,
      if (space != null) 'space': space,
      if (equipment != null) 'equipment': equipment,
      if (type != null) 'type': type,
      if (lengthS != null) 'length_s': lengthS,
      if (constraintsJson != null) 'constraints_json': constraintsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PresetsCompanion copyWith({
    Value<int>? id,
    Value<GradeBand>? gradeBand,
    Value<SpaceType>? space,
    Value<String>? equipment,
    Value<RoutineType>? type,
    Value<int>? lengthS,
    Value<String>? constraintsJson,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PresetsCompanion(
      id: id ?? this.id,
      gradeBand: gradeBand ?? this.gradeBand,
      space: space ?? this.space,
      equipment: equipment ?? this.equipment,
      type: type ?? this.type,
      lengthS: lengthS ?? this.lengthS,
      constraintsJson: constraintsJson ?? this.constraintsJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gradeBand.present) {
      map['grade_band'] = Variable<int>(
        $PresetsTable.$convertergradeBand.toSql(gradeBand.value),
      );
    }
    if (space.present) {
      map['space'] = Variable<int>(
        $PresetsTable.$converterspace.toSql(space.value),
      );
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $PresetsTable.$convertertype.toSql(type.value),
      );
    }
    if (lengthS.present) {
      map['length_s'] = Variable<int>(lengthS.value);
    }
    if (constraintsJson.present) {
      map['constraints_json'] = Variable<String>(constraintsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PresetsCompanion(')
          ..write('id: $id, ')
          ..write('gradeBand: $gradeBand, ')
          ..write('space: $space, ')
          ..write('equipment: $equipment, ')
          ..write('type: $type, ')
          ..write('lengthS: $lengthS, ')
          ..write('constraintsJson: $constraintsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routines (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesJsonMeta = const VerificationMeta(
    'notesJson',
  );
  @override
  late final GeneratedColumn<String> notesJson = GeneratedColumn<String>(
    'notes_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    startedAt,
    endedAt,
    notesJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('notes_json')) {
      context.handle(
        _notesJsonMeta,
        notesJson.isAcceptableOrUnknown(data['notes_json']!, _notesJsonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}routine_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      notesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes_json'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final int id;
  final int routineId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String? notesJson;
  final DateTime createdAt;
  const Session({
    required this.id,
    required this.routineId,
    required this.startedAt,
    this.endedAt,
    this.notesJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['routine_id'] = Variable<int>(routineId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || notesJson != null) {
      map['notes_json'] = Variable<String>(notesJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      routineId: Value(routineId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      notesJson: notesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(notesJson),
      createdAt: Value(createdAt),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<int>(json['id']),
      routineId: serializer.fromJson<int>(json['routineId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      notesJson: serializer.fromJson<String?>(json['notesJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routineId': serializer.toJson<int>(routineId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'notesJson': serializer.toJson<String?>(notesJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Session copyWith({
    int? id,
    int? routineId,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    Value<String?> notesJson = const Value.absent(),
    DateTime? createdAt,
  }) => Session(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    notesJson: notesJson.present ? notesJson.value : this.notesJson,
    createdAt: createdAt ?? this.createdAt,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      notesJson: data.notesJson.present ? data.notesJson.value : this.notesJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('notesJson: $notesJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, routineId, startedAt, endedAt, notesJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.notesJson == this.notesJson &&
          other.createdAt == this.createdAt);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<int> id;
  final Value<int> routineId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<String?> notesJson;
  final Value<DateTime> createdAt;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.notesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required int routineId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.notesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : routineId = Value(routineId),
       startedAt = Value(startedAt);
  static Insertable<Session> custom({
    Expression<int>? id,
    Expression<int>? routineId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? notesJson,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (notesJson != null) 'notes_json': notesJson,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? routineId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<String?>? notesJson,
    Value<DateTime>? createdAt,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      notesJson: notesJson ?? this.notesJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (notesJson.present) {
      map['notes_json'] = Variable<String>(notesJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('notesJson: $notesJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _valueJsonMeta = const VerificationMeta(
    'valueJson',
  );
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
    'value_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, key, valueJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(
        _valueJsonMeta,
        valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_valueJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      valueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final String key;
  final String valueJson;
  final DateTime updatedAt;
  const Setting({
    required this.id,
    required this.key,
    required this.valueJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['value_json'] = Variable<String>(valueJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      key: Value(key),
      valueJson: Value(valueJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      valueJson: serializer.fromJson<String>(json['valueJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'valueJson': serializer.toJson<String>(valueJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Setting copyWith({
    int? id,
    String? key,
    String? valueJson,
    DateTime? updatedAt,
  }) => Setting(
    id: id ?? this.id,
    key: key ?? this.key,
    valueJson: valueJson ?? this.valueJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, valueJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.key == this.key &&
          other.valueJson == this.valueJson &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> valueJson;
  final Value<DateTime> updatedAt;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String valueJson,
    this.updatedAt = const Value.absent(),
  }) : key = Value(key),
       valueJson = Value(valueJson);
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? valueJson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (valueJson != null) 'value_json': valueJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<String>? valueJson,
    Value<DateTime>? updatedAt,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      valueJson: valueJson ?? this.valueJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $VoicePacksTable extends VoicePacks
    with TableInfo<$VoicePacksTable, VoicePack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VoicePacksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
    'speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _pitchMeta = const VerificationMeta('pitch');
  @override
  late final GeneratedColumn<double> pitch = GeneratedColumn<double>(
    'pitch',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    locale,
    speed,
    pitch,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'voice_packs';
  @override
  VerificationContext validateIntegrity(
    Insertable<VoicePack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
        _speedMeta,
        speed.isAcceptableOrUnknown(data['speed']!, _speedMeta),
      );
    }
    if (data.containsKey('pitch')) {
      context.handle(
        _pitchMeta,
        pitch.isAcceptableOrUnknown(data['pitch']!, _pitchMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VoicePack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VoicePack(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      speed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed'],
      )!,
      pitch: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pitch'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VoicePacksTable createAlias(String alias) {
    return $VoicePacksTable(attachedDatabase, alias);
  }
}

class VoicePack extends DataClass implements Insertable<VoicePack> {
  final int id;
  final String name;
  final String locale;
  final double speed;
  final double pitch;
  final DateTime createdAt;
  const VoicePack({
    required this.id,
    required this.name,
    required this.locale,
    required this.speed,
    required this.pitch,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['locale'] = Variable<String>(locale);
    map['speed'] = Variable<double>(speed);
    map['pitch'] = Variable<double>(pitch);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VoicePacksCompanion toCompanion(bool nullToAbsent) {
    return VoicePacksCompanion(
      id: Value(id),
      name: Value(name),
      locale: Value(locale),
      speed: Value(speed),
      pitch: Value(pitch),
      createdAt: Value(createdAt),
    );
  }

  factory VoicePack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VoicePack(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      locale: serializer.fromJson<String>(json['locale']),
      speed: serializer.fromJson<double>(json['speed']),
      pitch: serializer.fromJson<double>(json['pitch']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'locale': serializer.toJson<String>(locale),
      'speed': serializer.toJson<double>(speed),
      'pitch': serializer.toJson<double>(pitch),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VoicePack copyWith({
    int? id,
    String? name,
    String? locale,
    double? speed,
    double? pitch,
    DateTime? createdAt,
  }) => VoicePack(
    id: id ?? this.id,
    name: name ?? this.name,
    locale: locale ?? this.locale,
    speed: speed ?? this.speed,
    pitch: pitch ?? this.pitch,
    createdAt: createdAt ?? this.createdAt,
  );
  VoicePack copyWithCompanion(VoicePacksCompanion data) {
    return VoicePack(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      locale: data.locale.present ? data.locale.value : this.locale,
      speed: data.speed.present ? data.speed.value : this.speed,
      pitch: data.pitch.present ? data.pitch.value : this.pitch,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VoicePack(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('locale: $locale, ')
          ..write('speed: $speed, ')
          ..write('pitch: $pitch, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, locale, speed, pitch, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VoicePack &&
          other.id == this.id &&
          other.name == this.name &&
          other.locale == this.locale &&
          other.speed == this.speed &&
          other.pitch == this.pitch &&
          other.createdAt == this.createdAt);
}

class VoicePacksCompanion extends UpdateCompanion<VoicePack> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> locale;
  final Value<double> speed;
  final Value<double> pitch;
  final Value<DateTime> createdAt;
  const VoicePacksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.locale = const Value.absent(),
    this.speed = const Value.absent(),
    this.pitch = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VoicePacksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String locale,
    this.speed = const Value.absent(),
    this.pitch = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       locale = Value(locale);
  static Insertable<VoicePack> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? locale,
    Expression<double>? speed,
    Expression<double>? pitch,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (locale != null) 'locale': locale,
      if (speed != null) 'speed': speed,
      if (pitch != null) 'pitch': pitch,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VoicePacksCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? locale,
    Value<double>? speed,
    Value<double>? pitch,
    Value<DateTime>? createdAt,
  }) {
    return VoicePacksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      locale: locale ?? this.locale,
      speed: speed ?? this.speed,
      pitch: pitch ?? this.pitch,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (pitch.present) {
      map['pitch'] = Variable<double>(pitch.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VoicePacksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('locale: $locale, ')
          ..write('speed: $speed, ')
          ..write('pitch: $pitch, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MovesTable moves = $MovesTable(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $PresetsTable presets = $PresetsTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $VoicePacksTable voicePacks = $VoicePacksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    moves,
    routines,
    presets,
    sessions,
    settings,
    voicePacks,
  ];
}

typedef $$MovesTableCreateCompanionBuilder =
    MovesCompanion Function({
      Value<int> id,
      required String name,
      required String tags,
      required int gradeMin,
      required int gradeMax,
      required SpaceType needsSpace,
      required String needsEquipment,
      required ImpactLevel impact,
      required NoiseLevel noise,
      Value<bool> allowFloor,
      Value<int> defaultDurationS,
      Value<String?> keyframes,
      Value<String?> lottieAssetPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$MovesTableUpdateCompanionBuilder =
    MovesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> tags,
      Value<int> gradeMin,
      Value<int> gradeMax,
      Value<SpaceType> needsSpace,
      Value<String> needsEquipment,
      Value<ImpactLevel> impact,
      Value<NoiseLevel> noise,
      Value<bool> allowFloor,
      Value<int> defaultDurationS,
      Value<String?> keyframes,
      Value<String?> lottieAssetPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$MovesTableFilterComposer extends Composer<_$AppDatabase, $MovesTable> {
  $$MovesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gradeMin => $composableBuilder(
    column: $table.gradeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gradeMax => $composableBuilder(
    column: $table.gradeMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SpaceType, SpaceType, int> get needsSpace =>
      $composableBuilder(
        column: $table.needsSpace,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get needsEquipment => $composableBuilder(
    column: $table.needsEquipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ImpactLevel, ImpactLevel, int> get impact =>
      $composableBuilder(
        column: $table.impact,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<NoiseLevel, NoiseLevel, int> get noise =>
      $composableBuilder(
        column: $table.noise,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get allowFloor => $composableBuilder(
    column: $table.allowFloor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultDurationS => $composableBuilder(
    column: $table.defaultDurationS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyframes => $composableBuilder(
    column: $table.keyframes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lottieAssetPath => $composableBuilder(
    column: $table.lottieAssetPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MovesTableOrderingComposer
    extends Composer<_$AppDatabase, $MovesTable> {
  $$MovesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gradeMin => $composableBuilder(
    column: $table.gradeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gradeMax => $composableBuilder(
    column: $table.gradeMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get needsSpace => $composableBuilder(
    column: $table.needsSpace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get needsEquipment => $composableBuilder(
    column: $table.needsEquipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get impact => $composableBuilder(
    column: $table.impact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get noise => $composableBuilder(
    column: $table.noise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allowFloor => $composableBuilder(
    column: $table.allowFloor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultDurationS => $composableBuilder(
    column: $table.defaultDurationS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyframes => $composableBuilder(
    column: $table.keyframes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lottieAssetPath => $composableBuilder(
    column: $table.lottieAssetPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MovesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovesTable> {
  $$MovesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<int> get gradeMin =>
      $composableBuilder(column: $table.gradeMin, builder: (column) => column);

  GeneratedColumn<int> get gradeMax =>
      $composableBuilder(column: $table.gradeMax, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SpaceType, int> get needsSpace =>
      $composableBuilder(
        column: $table.needsSpace,
        builder: (column) => column,
      );

  GeneratedColumn<String> get needsEquipment => $composableBuilder(
    column: $table.needsEquipment,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ImpactLevel, int> get impact =>
      $composableBuilder(column: $table.impact, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NoiseLevel, int> get noise =>
      $composableBuilder(column: $table.noise, builder: (column) => column);

  GeneratedColumn<bool> get allowFloor => $composableBuilder(
    column: $table.allowFloor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultDurationS => $composableBuilder(
    column: $table.defaultDurationS,
    builder: (column) => column,
  );

  GeneratedColumn<String> get keyframes =>
      $composableBuilder(column: $table.keyframes, builder: (column) => column);

  GeneratedColumn<String> get lottieAssetPath => $composableBuilder(
    column: $table.lottieAssetPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MovesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovesTable,
          Move,
          $$MovesTableFilterComposer,
          $$MovesTableOrderingComposer,
          $$MovesTableAnnotationComposer,
          $$MovesTableCreateCompanionBuilder,
          $$MovesTableUpdateCompanionBuilder,
          (Move, BaseReferences<_$AppDatabase, $MovesTable, Move>),
          Move,
          PrefetchHooks Function()
        > {
  $$MovesTableTableManager(_$AppDatabase db, $MovesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int> gradeMin = const Value.absent(),
                Value<int> gradeMax = const Value.absent(),
                Value<SpaceType> needsSpace = const Value.absent(),
                Value<String> needsEquipment = const Value.absent(),
                Value<ImpactLevel> impact = const Value.absent(),
                Value<NoiseLevel> noise = const Value.absent(),
                Value<bool> allowFloor = const Value.absent(),
                Value<int> defaultDurationS = const Value.absent(),
                Value<String?> keyframes = const Value.absent(),
                Value<String?> lottieAssetPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MovesCompanion(
                id: id,
                name: name,
                tags: tags,
                gradeMin: gradeMin,
                gradeMax: gradeMax,
                needsSpace: needsSpace,
                needsEquipment: needsEquipment,
                impact: impact,
                noise: noise,
                allowFloor: allowFloor,
                defaultDurationS: defaultDurationS,
                keyframes: keyframes,
                lottieAssetPath: lottieAssetPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String tags,
                required int gradeMin,
                required int gradeMax,
                required SpaceType needsSpace,
                required String needsEquipment,
                required ImpactLevel impact,
                required NoiseLevel noise,
                Value<bool> allowFloor = const Value.absent(),
                Value<int> defaultDurationS = const Value.absent(),
                Value<String?> keyframes = const Value.absent(),
                Value<String?> lottieAssetPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MovesCompanion.insert(
                id: id,
                name: name,
                tags: tags,
                gradeMin: gradeMin,
                gradeMax: gradeMax,
                needsSpace: needsSpace,
                needsEquipment: needsEquipment,
                impact: impact,
                noise: noise,
                allowFloor: allowFloor,
                defaultDurationS: defaultDurationS,
                keyframes: keyframes,
                lottieAssetPath: lottieAssetPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MovesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovesTable,
      Move,
      $$MovesTableFilterComposer,
      $$MovesTableOrderingComposer,
      $$MovesTableAnnotationComposer,
      $$MovesTableCreateCompanionBuilder,
      $$MovesTableUpdateCompanionBuilder,
      (Move, BaseReferences<_$AppDatabase, $MovesTable, Move>),
      Move,
      PrefetchHooks Function()
    >;
typedef $$RoutinesTableCreateCompanionBuilder =
    RoutinesCompanion Function({
      Value<int> id,
      required String name,
      required int totalSeconds,
      required String blocksJson,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$RoutinesTableUpdateCompanionBuilder =
    RoutinesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> totalSeconds,
      Value<String> blocksJson,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$RoutinesTableReferences
    extends BaseReferences<_$AppDatabase, $RoutinesTable, Routine> {
  $$RoutinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SessionsTable, List<Session>> _sessionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sessions,
    aliasName: $_aliasNameGenerator(db.routines.id, db.sessions.routineId),
  );

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSeconds => $composableBuilder(
    column: $table.totalSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blocksJson => $composableBuilder(
    column: $table.blocksJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sessionsRefs(
    Expression<bool> Function($$SessionsTableFilterComposer f) f,
  ) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSeconds => $composableBuilder(
    column: $table.totalSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blocksJson => $composableBuilder(
    column: $table.blocksJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get totalSeconds => $composableBuilder(
    column: $table.totalSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get blocksJson => $composableBuilder(
    column: $table.blocksJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> sessionsRefs<T extends Object>(
    Expression<T> Function($$SessionsTableAnnotationComposer a) f,
  ) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutinesTable,
          Routine,
          $$RoutinesTableFilterComposer,
          $$RoutinesTableOrderingComposer,
          $$RoutinesTableAnnotationComposer,
          $$RoutinesTableCreateCompanionBuilder,
          $$RoutinesTableUpdateCompanionBuilder,
          (Routine, $$RoutinesTableReferences),
          Routine,
          PrefetchHooks Function({bool sessionsRefs})
        > {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> totalSeconds = const Value.absent(),
                Value<String> blocksJson = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RoutinesCompanion(
                id: id,
                name: name,
                totalSeconds: totalSeconds,
                blocksJson: blocksJson,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int totalSeconds,
                required String blocksJson,
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RoutinesCompanion.insert(
                id: id,
                name: name,
                totalSeconds: totalSeconds,
                blocksJson: blocksJson,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RoutinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (sessionsRefs) db.sessions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sessionsRefs)
                    await $_getPrefetchedData<Routine, $RoutinesTable, Session>(
                      currentTable: table,
                      referencedTable: $$RoutinesTableReferences
                          ._sessionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RoutinesTableReferences(db, table, p0).sessionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.routineId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RoutinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutinesTable,
      Routine,
      $$RoutinesTableFilterComposer,
      $$RoutinesTableOrderingComposer,
      $$RoutinesTableAnnotationComposer,
      $$RoutinesTableCreateCompanionBuilder,
      $$RoutinesTableUpdateCompanionBuilder,
      (Routine, $$RoutinesTableReferences),
      Routine,
      PrefetchHooks Function({bool sessionsRefs})
    >;
typedef $$PresetsTableCreateCompanionBuilder =
    PresetsCompanion Function({
      Value<int> id,
      required GradeBand gradeBand,
      required SpaceType space,
      required String equipment,
      required RoutineType type,
      required int lengthS,
      required String constraintsJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$PresetsTableUpdateCompanionBuilder =
    PresetsCompanion Function({
      Value<int> id,
      Value<GradeBand> gradeBand,
      Value<SpaceType> space,
      Value<String> equipment,
      Value<RoutineType> type,
      Value<int> lengthS,
      Value<String> constraintsJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$PresetsTableFilterComposer
    extends Composer<_$AppDatabase, $PresetsTable> {
  $$PresetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GradeBand, GradeBand, int> get gradeBand =>
      $composableBuilder(
        column: $table.gradeBand,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SpaceType, SpaceType, int> get space =>
      $composableBuilder(
        column: $table.space,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RoutineType, RoutineType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get lengthS => $composableBuilder(
    column: $table.lengthS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get constraintsJson => $composableBuilder(
    column: $table.constraintsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PresetsTableOrderingComposer
    extends Composer<_$AppDatabase, $PresetsTable> {
  $$PresetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gradeBand => $composableBuilder(
    column: $table.gradeBand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get space => $composableBuilder(
    column: $table.space,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lengthS => $composableBuilder(
    column: $table.lengthS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get constraintsJson => $composableBuilder(
    column: $table.constraintsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PresetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PresetsTable> {
  $$PresetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GradeBand, int> get gradeBand =>
      $composableBuilder(column: $table.gradeBand, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SpaceType, int> get space =>
      $composableBuilder(column: $table.space, builder: (column) => column);

  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RoutineType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get lengthS =>
      $composableBuilder(column: $table.lengthS, builder: (column) => column);

  GeneratedColumn<String> get constraintsJson => $composableBuilder(
    column: $table.constraintsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PresetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PresetsTable,
          Preset,
          $$PresetsTableFilterComposer,
          $$PresetsTableOrderingComposer,
          $$PresetsTableAnnotationComposer,
          $$PresetsTableCreateCompanionBuilder,
          $$PresetsTableUpdateCompanionBuilder,
          (Preset, BaseReferences<_$AppDatabase, $PresetsTable, Preset>),
          Preset,
          PrefetchHooks Function()
        > {
  $$PresetsTableTableManager(_$AppDatabase db, $PresetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PresetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PresetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PresetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<GradeBand> gradeBand = const Value.absent(),
                Value<SpaceType> space = const Value.absent(),
                Value<String> equipment = const Value.absent(),
                Value<RoutineType> type = const Value.absent(),
                Value<int> lengthS = const Value.absent(),
                Value<String> constraintsJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PresetsCompanion(
                id: id,
                gradeBand: gradeBand,
                space: space,
                equipment: equipment,
                type: type,
                lengthS: lengthS,
                constraintsJson: constraintsJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required GradeBand gradeBand,
                required SpaceType space,
                required String equipment,
                required RoutineType type,
                required int lengthS,
                required String constraintsJson,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PresetsCompanion.insert(
                id: id,
                gradeBand: gradeBand,
                space: space,
                equipment: equipment,
                type: type,
                lengthS: lengthS,
                constraintsJson: constraintsJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PresetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PresetsTable,
      Preset,
      $$PresetsTableFilterComposer,
      $$PresetsTableOrderingComposer,
      $$PresetsTableAnnotationComposer,
      $$PresetsTableCreateCompanionBuilder,
      $$PresetsTableUpdateCompanionBuilder,
      (Preset, BaseReferences<_$AppDatabase, $PresetsTable, Preset>),
      Preset,
      PrefetchHooks Function()
    >;
typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      required int routineId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<String?> notesJson,
      Value<DateTime> createdAt,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      Value<int> routineId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<String?> notesJson,
      Value<DateTime> createdAt,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoutinesTable _routineIdTable(_$AppDatabase db) => db.routines
      .createAlias($_aliasNameGenerator(db.sessions.routineId, db.routines.id));

  $$RoutinesTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<int>('routine_id')!;

    final manager = $$RoutinesTableTableManager(
      $_db,
      $_db.routines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notesJson => $composableBuilder(
    column: $table.notesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableFilterComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notesJson => $composableBuilder(
    column: $table.notesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableOrderingComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get notesJson =>
      $composableBuilder(column: $table.notesJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableAnnotationComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, $$SessionsTableReferences),
          Session,
          PrefetchHooks Function({bool routineId})
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> routineId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String?> notesJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                routineId: routineId,
                startedAt: startedAt,
                endedAt: endedAt,
                notesJson: notesJson,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int routineId,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String?> notesJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                routineId: routineId,
                startedAt: startedAt,
                endedAt: endedAt,
                notesJson: notesJson,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (routineId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.routineId,
                                referencedTable: $$SessionsTableReferences
                                    ._routineIdTable(db),
                                referencedColumn: $$SessionsTableReferences
                                    ._routineIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, $$SessionsTableReferences),
      Session,
      PrefetchHooks Function({bool routineId})
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      required String key,
      required String valueJson,
      Value<DateTime> updatedAt,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<String> key,
      Value<String> valueJson,
      Value<DateTime> updatedAt,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get valueJson =>
      $composableBuilder(column: $table.valueJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> valueJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                key: key,
                valueJson: valueJson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required String valueJson,
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SettingsCompanion.insert(
                id: id,
                key: key,
                valueJson: valueJson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;
typedef $$VoicePacksTableCreateCompanionBuilder =
    VoicePacksCompanion Function({
      Value<int> id,
      required String name,
      required String locale,
      Value<double> speed,
      Value<double> pitch,
      Value<DateTime> createdAt,
    });
typedef $$VoicePacksTableUpdateCompanionBuilder =
    VoicePacksCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> locale,
      Value<double> speed,
      Value<double> pitch,
      Value<DateTime> createdAt,
    });

class $$VoicePacksTableFilterComposer
    extends Composer<_$AppDatabase, $VoicePacksTable> {
  $$VoicePacksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pitch => $composableBuilder(
    column: $table.pitch,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VoicePacksTableOrderingComposer
    extends Composer<_$AppDatabase, $VoicePacksTable> {
  $$VoicePacksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pitch => $composableBuilder(
    column: $table.pitch,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VoicePacksTableAnnotationComposer
    extends Composer<_$AppDatabase, $VoicePacksTable> {
  $$VoicePacksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<double> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<double> get pitch =>
      $composableBuilder(column: $table.pitch, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$VoicePacksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VoicePacksTable,
          VoicePack,
          $$VoicePacksTableFilterComposer,
          $$VoicePacksTableOrderingComposer,
          $$VoicePacksTableAnnotationComposer,
          $$VoicePacksTableCreateCompanionBuilder,
          $$VoicePacksTableUpdateCompanionBuilder,
          (
            VoicePack,
            BaseReferences<_$AppDatabase, $VoicePacksTable, VoicePack>,
          ),
          VoicePack,
          PrefetchHooks Function()
        > {
  $$VoicePacksTableTableManager(_$AppDatabase db, $VoicePacksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VoicePacksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VoicePacksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VoicePacksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<double> speed = const Value.absent(),
                Value<double> pitch = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => VoicePacksCompanion(
                id: id,
                name: name,
                locale: locale,
                speed: speed,
                pitch: pitch,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String locale,
                Value<double> speed = const Value.absent(),
                Value<double> pitch = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => VoicePacksCompanion.insert(
                id: id,
                name: name,
                locale: locale,
                speed: speed,
                pitch: pitch,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VoicePacksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VoicePacksTable,
      VoicePack,
      $$VoicePacksTableFilterComposer,
      $$VoicePacksTableOrderingComposer,
      $$VoicePacksTableAnnotationComposer,
      $$VoicePacksTableCreateCompanionBuilder,
      $$VoicePacksTableUpdateCompanionBuilder,
      (VoicePack, BaseReferences<_$AppDatabase, $VoicePacksTable, VoicePack>),
      VoicePack,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MovesTableTableManager get moves =>
      $$MovesTableTableManager(_db, _db.moves);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$PresetsTableTableManager get presets =>
      $$PresetsTableTableManager(_db, _db.presets);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$VoicePacksTableTableManager get voicePacks =>
      $$VoicePacksTableTableManager(_db, _db.voicePacks);
}
