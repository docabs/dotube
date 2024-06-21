import 'package:envied/envied.dart';
import 'package:dotube/utils/platform.dart';

part 'env.g.dart';

enum ReleaseChannel {
  nightly,
  stable,
}

@Envied(obfuscate: true, requireEnvFile: true, path: ".env")
abstract class Env {
  @EnviedField(varName: 'SPOTIFY_SECRETS')
  static final String rawSpotifySecrets = _Env.rawSpotifySecrets;

  @EnviedField(varName: 'LASTFM_API_KEY')
  static final String lastFmApiKey = _Env.lastFmApiKey;

  @EnviedField(varName: 'LASTFM_API_SECRET')
  static final String lastFmApiSecret = _Env.lastFmApiSecret;

  static final spotifySecrets = rawSpotifySecrets.split(',').map((e) {
    final secrets = e.trim().split(":").map((e) => e.trim());
    return {
      "clientId": secrets.first,
      "clientSecret": secrets.last,
    };
  }).toList();

  @EnviedField(varName: 'ENABLE_UPDATE_CHECK', defaultValue: "1")
  static final String _enableUpdateChecker = _Env._enableUpdateChecker;

  @EnviedField(varName: "RELEASE_CHANNEL", defaultValue: "nightly")
  static final String _releaseChannel = _Env._releaseChannel;

  static ReleaseChannel get releaseChannel =>
      _releaseChannel == "stable" ? ReleaseChannel.stable : ReleaseChannel.nightly;

  static bool get enableUpdateChecker => kIsFlatpak || _enableUpdateChecker == "1";

  static String discordAppId = "1176718791388975124";
}
