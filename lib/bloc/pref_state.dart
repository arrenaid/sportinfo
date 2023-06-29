import 'package:equatable/equatable.dart';

class PrefState extends Equatable{
  final String url;
  final bool isEmu;
  final bool isVpn;
  const PrefState(this.url, this.isEmu, this.isVpn);

  @override
  List<Object?> get props => [url, isEmu,isVpn];
}