import 'package:fred_meat/generated/generated_proto.pb.dart' as pb;
import 'models/settings.dart';

extension SettingsProtoExtension on pb.Settings {
  Settings toDomain() => Settings(test: hasTest() ? test : false);
}

extension SettingsDomainExtension on Settings {
  pb.Settings toProto() => pb.Settings(test: test);
}
