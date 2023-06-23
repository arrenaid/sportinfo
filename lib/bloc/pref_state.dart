import 'package:equatable/equatable.dart';

class PrefState extends Equatable{
  final String url;
  final bool access;
  PrefState(this.url, this.access);

  @override
  List<Object?> get props => [url, access];
}