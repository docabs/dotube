import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify/spotify.dart';
import 'package:dotube/configs/env.dart';

import 'package:dotube/provider/authentication_provider.dart';
import 'package:dotube/utils/primitive_utils.dart';

final spotifyProvider = Provider<SpotifyApi>((ref) {
  final authState = ref.watch(authenticationProvider);
  final anonCred = PrimitiveUtils.getRandomElement(Env.spotifySecrets);

  if (authState == null) {
    return SpotifyApi(
      SpotifyApiCredentials(
        anonCred["clientId"],
        anonCred["clientSecret"],
      ),
    );
  }

  return SpotifyApi.withAccessToken(authState.accessToken);
});
