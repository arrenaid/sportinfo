import 'package:equatable/equatable.dart';

class PrefState extends Equatable{
  final String url;
  final bool access;
  final bool isEmu;
  final bool isVpn;
  const PrefState(this.url, this.access, this.isEmu, this.isVpn);

  @override
  List<Object?> get props => [url, access,isEmu,isVpn];
}