// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saegim_database.dart';

// ignore_for_file: type=lint
class $ScheduleTable extends Schedule
    with TableInfo<$ScheduleTable, ScheduleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    category,
    date,
    startTime,
    endTime,
    content,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
    );
  }

  @override
  $ScheduleTable createAlias(String alias) {
    return $ScheduleTable(attachedDatabase, alias);
  }
}

class ScheduleData extends DataClass implements Insertable<ScheduleData> {
  final int id;
  final String title;
  final String category;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String content;
  const ScheduleData({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.content,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['date'] = Variable<DateTime>(date);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['content'] = Variable<String>(content);
    return map;
  }

  ScheduleCompanion toCompanion(bool nullToAbsent) {
    return ScheduleCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      date: Value(date),
      startTime: Value(startTime),
      endTime: Value(endTime),
      content: Value(content),
    );
  }

  factory ScheduleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      date: serializer.fromJson<DateTime>(json['date']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'date': serializer.toJson<DateTime>(date),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'content': serializer.toJson<String>(content),
    };
  }

  ScheduleData copyWith({
    int? id,
    String? title,
    String? category,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    String? content,
  }) => ScheduleData(
    id: id ?? this.id,
    title: title ?? this.title,
    category: category ?? this.category,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    content: content ?? this.content,
  );
  ScheduleData copyWithCompanion(ScheduleCompanion data) {
    return ScheduleData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      date: data.date.present ? data.date.value : this.date,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, category, date, startTime, endTime, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleData &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.date == this.date &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.content == this.content);
}

class ScheduleCompanion extends UpdateCompanion<ScheduleData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> category;
  final Value<DateTime> date;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<String> content;
  const ScheduleCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.content = const Value.absent(),
  });
  ScheduleCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String category,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    required String content,
  }) : title = Value(title),
       category = Value(category),
       date = Value(date),
       startTime = Value(startTime),
       endTime = Value(endTime),
       content = Value(content);
  static Insertable<ScheduleData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<DateTime>? date,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (content != null) 'content': content,
    });
  }

  ScheduleCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? category,
    Value<DateTime>? date,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<String>? content,
  }) {
    return ScheduleCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $MemoTable extends Memo with TableInfo<$MemoTable, MemoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, content, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memo';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $MemoTable createAlias(String alias) {
    return $MemoTable(attachedDatabase, alias);
  }
}

class MemoData extends DataClass implements Insertable<MemoData> {
  final int id;
  final String title;
  final String content;
  final DateTime date;
  const MemoData({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  MemoCompanion toCompanion(bool nullToAbsent) {
    return MemoCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      date: Value(date),
    );
  }

  factory MemoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  MemoData copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? date,
  }) => MemoData(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    date: date ?? this.date,
  );
  MemoData copyWithCompanion(MemoCompanion data) {
    return MemoData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemoData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoData &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.date == this.date);
}

class MemoCompanion extends UpdateCompanion<MemoData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<DateTime> date;
  const MemoCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.date = const Value.absent(),
  });
  MemoCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    required DateTime date,
  }) : title = Value(title),
       content = Value(content),
       date = Value(date);
  static Insertable<MemoData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (date != null) 'date': date,
    });
  }

  MemoCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? content,
    Value<DateTime>? date,
  }) {
    return MemoCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $DdayTable extends Dday with TableInfo<$DdayTable, DdayData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DdayTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DdayType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DdayType>($DdayTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    startTime,
    endTime,
    content,
    type,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dday';
  @override
  VerificationContext validateIntegrity(
    Insertable<DdayData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DdayData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DdayData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      type: $DdayTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $DdayTable createAlias(String alias) {
    return $DdayTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DdayType, String, String> $convertertype =
      const EnumNameConverter<DdayType>(DdayType.values);
}

class DdayData extends DataClass implements Insertable<DdayData> {
  final int id;
  final String title;
  final DateTime startTime;
  final DateTime? endTime;
  final String content;
  final DdayType type;
  const DdayData({
    required this.id,
    required this.title,
    required this.startTime,
    this.endTime,
    required this.content,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['content'] = Variable<String>(content);
    {
      map['type'] = Variable<String>($DdayTable.$convertertype.toSql(type));
    }
    return map;
  }

  DdayCompanion toCompanion(bool nullToAbsent) {
    return DdayCompanion(
      id: Value(id),
      title: Value(title),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      content: Value(content),
      type: Value(type),
    );
  }

  factory DdayData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DdayData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      content: serializer.fromJson<String>(json['content']),
      type: $DdayTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'content': serializer.toJson<String>(content),
      'type': serializer.toJson<String>($DdayTable.$convertertype.toJson(type)),
    };
  }

  DdayData copyWith({
    int? id,
    String? title,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    String? content,
    DdayType? type,
  }) => DdayData(
    id: id ?? this.id,
    title: title ?? this.title,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    content: content ?? this.content,
    type: type ?? this.type,
  );
  DdayData copyWithCompanion(DdayCompanion data) {
    return DdayData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      content: data.content.present ? data.content.value : this.content,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DdayData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('content: $content, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, startTime, endTime, content, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DdayData &&
          other.id == this.id &&
          other.title == this.title &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.content == this.content &&
          other.type == this.type);
}

class DdayCompanion extends UpdateCompanion<DdayData> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<String> content;
  final Value<DdayType> type;
  const DdayCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.content = const Value.absent(),
    this.type = const Value.absent(),
  });
  DdayCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    required String content,
    required DdayType type,
  }) : title = Value(title),
       startTime = Value(startTime),
       content = Value(content),
       type = Value(type);
  static Insertable<DdayData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? content,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (content != null) 'content': content,
      if (type != null) 'type': type,
    });
  }

  DdayCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<String>? content,
    Value<DdayType>? type,
  }) {
    return DdayCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      content: content ?? this.content,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $DdayTable.$convertertype.toSql(type.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DdayCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('content: $content, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $ScheduleTable schedule = $ScheduleTable(this);
  late final $MemoTable memo = $MemoTable(this);
  late final $DdayTable dday = $DdayTable(this);
  late final ScheduleDao scheduleDao = ScheduleDao(this as LocalDatabase);
  late final MemoDao memoDao = MemoDao(this as LocalDatabase);
  late final DdayDao ddayDao = DdayDao(this as LocalDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [schedule, memo, dday];
}

typedef $$ScheduleTableCreateCompanionBuilder =
    ScheduleCompanion Function({
      Value<int> id,
      required String title,
      required String category,
      required DateTime date,
      required DateTime startTime,
      required DateTime endTime,
      required String content,
    });
typedef $$ScheduleTableUpdateCompanionBuilder =
    ScheduleCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> category,
      Value<DateTime> date,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<String> content,
    });

class $$ScheduleTableFilterComposer
    extends Composer<_$LocalDatabase, $ScheduleTable> {
  $$ScheduleTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScheduleTableOrderingComposer
    extends Composer<_$LocalDatabase, $ScheduleTable> {
  $$ScheduleTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScheduleTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ScheduleTable> {
  $$ScheduleTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $$ScheduleTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ScheduleTable,
          ScheduleData,
          $$ScheduleTableFilterComposer,
          $$ScheduleTableOrderingComposer,
          $$ScheduleTableAnnotationComposer,
          $$ScheduleTableCreateCompanionBuilder,
          $$ScheduleTableUpdateCompanionBuilder,
          (
            ScheduleData,
            BaseReferences<_$LocalDatabase, $ScheduleTable, ScheduleData>,
          ),
          ScheduleData,
          PrefetchHooks Function()
        > {
  $$ScheduleTableTableManager(_$LocalDatabase db, $ScheduleTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<String> content = const Value.absent(),
              }) => ScheduleCompanion(
                id: id,
                title: title,
                category: category,
                date: date,
                startTime: startTime,
                endTime: endTime,
                content: content,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String category,
                required DateTime date,
                required DateTime startTime,
                required DateTime endTime,
                required String content,
              }) => ScheduleCompanion.insert(
                id: id,
                title: title,
                category: category,
                date: date,
                startTime: startTime,
                endTime: endTime,
                content: content,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScheduleTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ScheduleTable,
      ScheduleData,
      $$ScheduleTableFilterComposer,
      $$ScheduleTableOrderingComposer,
      $$ScheduleTableAnnotationComposer,
      $$ScheduleTableCreateCompanionBuilder,
      $$ScheduleTableUpdateCompanionBuilder,
      (
        ScheduleData,
        BaseReferences<_$LocalDatabase, $ScheduleTable, ScheduleData>,
      ),
      ScheduleData,
      PrefetchHooks Function()
    >;
typedef $$MemoTableCreateCompanionBuilder =
    MemoCompanion Function({
      Value<int> id,
      required String title,
      required String content,
      required DateTime date,
    });
typedef $$MemoTableUpdateCompanionBuilder =
    MemoCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> content,
      Value<DateTime> date,
    });

class $$MemoTableFilterComposer extends Composer<_$LocalDatabase, $MemoTable> {
  $$MemoTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MemoTableOrderingComposer
    extends Composer<_$LocalDatabase, $MemoTable> {
  $$MemoTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MemoTableAnnotationComposer
    extends Composer<_$LocalDatabase, $MemoTable> {
  $$MemoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$MemoTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $MemoTable,
          MemoData,
          $$MemoTableFilterComposer,
          $$MemoTableOrderingComposer,
          $$MemoTableAnnotationComposer,
          $$MemoTableCreateCompanionBuilder,
          $$MemoTableUpdateCompanionBuilder,
          (MemoData, BaseReferences<_$LocalDatabase, $MemoTable, MemoData>),
          MemoData,
          PrefetchHooks Function()
        > {
  $$MemoTableTableManager(_$LocalDatabase db, $MemoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => MemoCompanion(
                id: id,
                title: title,
                content: content,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String content,
                required DateTime date,
              }) => MemoCompanion.insert(
                id: id,
                title: title,
                content: content,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MemoTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $MemoTable,
      MemoData,
      $$MemoTableFilterComposer,
      $$MemoTableOrderingComposer,
      $$MemoTableAnnotationComposer,
      $$MemoTableCreateCompanionBuilder,
      $$MemoTableUpdateCompanionBuilder,
      (MemoData, BaseReferences<_$LocalDatabase, $MemoTable, MemoData>),
      MemoData,
      PrefetchHooks Function()
    >;
typedef $$DdayTableCreateCompanionBuilder =
    DdayCompanion Function({
      Value<int> id,
      required String title,
      required DateTime startTime,
      Value<DateTime?> endTime,
      required String content,
      required DdayType type,
    });
typedef $$DdayTableUpdateCompanionBuilder =
    DdayCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<String> content,
      Value<DdayType> type,
    });

class $$DdayTableFilterComposer extends Composer<_$LocalDatabase, $DdayTable> {
  $$DdayTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DdayType, DdayType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$DdayTableOrderingComposer
    extends Composer<_$LocalDatabase, $DdayTable> {
  $$DdayTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DdayTableAnnotationComposer
    extends Composer<_$LocalDatabase, $DdayTable> {
  $$DdayTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DdayType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$DdayTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $DdayTable,
          DdayData,
          $$DdayTableFilterComposer,
          $$DdayTableOrderingComposer,
          $$DdayTableAnnotationComposer,
          $$DdayTableCreateCompanionBuilder,
          $$DdayTableUpdateCompanionBuilder,
          (DdayData, BaseReferences<_$LocalDatabase, $DdayTable, DdayData>),
          DdayData,
          PrefetchHooks Function()
        > {
  $$DdayTableTableManager(_$LocalDatabase db, $DdayTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DdayTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DdayTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DdayTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DdayType> type = const Value.absent(),
              }) => DdayCompanion(
                id: id,
                title: title,
                startTime: startTime,
                endTime: endTime,
                content: content,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                required String content,
                required DdayType type,
              }) => DdayCompanion.insert(
                id: id,
                title: title,
                startTime: startTime,
                endTime: endTime,
                content: content,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DdayTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $DdayTable,
      DdayData,
      $$DdayTableFilterComposer,
      $$DdayTableOrderingComposer,
      $$DdayTableAnnotationComposer,
      $$DdayTableCreateCompanionBuilder,
      $$DdayTableUpdateCompanionBuilder,
      (DdayData, BaseReferences<_$LocalDatabase, $DdayTable, DdayData>),
      DdayData,
      PrefetchHooks Function()
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$ScheduleTableTableManager get schedule =>
      $$ScheduleTableTableManager(_db, _db.schedule);
  $$MemoTableTableManager get memo => $$MemoTableTableManager(_db, _db.memo);
  $$DdayTableTableManager get dday => $$DdayTableTableManager(_db, _db.dday);
}

mixin _$ScheduleDaoMixin on DatabaseAccessor<LocalDatabase> {
  $ScheduleTable get schedule => attachedDatabase.schedule;
}
mixin _$MemoDaoMixin on DatabaseAccessor<LocalDatabase> {
  $MemoTable get memo => attachedDatabase.memo;
}
mixin _$DdayDaoMixin on DatabaseAccessor<LocalDatabase> {
  $DdayTable get dday => attachedDatabase.dday;
}
