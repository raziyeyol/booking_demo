// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceImpl _$$ServiceImplFromJson(Map<String, dynamic> json) =>
    _$ServiceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      minutes: (json['minutes'] as num).toInt(),
      priceCents: (json['priceCents'] as num).toInt(),
      popular: json['popular'] as bool? ?? false,
    );

Map<String, dynamic> _$$ServiceImplToJson(_$ServiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'minutes': instance.minutes,
      'priceCents': instance.priceCents,
      'popular': instance.popular,
    };

_$StaffImpl _$$StaffImplFromJson(Map<String, dynamic> json) => _$StaffImpl(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$StaffImplToJson(_$StaffImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$TimeSlotImpl _$$TimeSlotImplFromJson(Map<String, dynamic> json) =>
    _$TimeSlotImpl(
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
    );

Map<String, dynamic> _$$TimeSlotImplToJson(_$TimeSlotImpl instance) =>
    <String, dynamic>{
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };

_$BookingImpl _$$BookingImplFromJson(Map<String, dynamic> json) =>
    _$BookingImpl(
      id: json['id'] as String,
      service: Service.fromJson(json['service'] as Map<String, dynamic>),
      staff: Staff.fromJson(json['staff'] as Map<String, dynamic>),
      slot: TimeSlot.fromJson(json['slot'] as Map<String, dynamic>),
      note: json['note'] as String? ?? '',
      paymentStatus: json['paymentStatus'] as String? ?? 'pending',
    );

Map<String, dynamic> _$$BookingImplToJson(_$BookingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service': instance.service,
      'staff': instance.staff,
      'slot': instance.slot,
      'note': instance.note,
      'paymentStatus': instance.paymentStatus,
    };
