import 'package:client/profile/Mes_Amis/mes_amis.dart';
import 'package:client/profile/Mes_Preferences/mes_preferences.dart';
import 'package:client/profile/Nvx_Mdp/nvx_mdp.dart';
import 'package:client/profile/Mon_Compte/mon_compte.dart';

getRoutes() {
  return {
    MonCompte.route: (context) => MonCompte(),
    MesAmis.route: (context) => MesAmis(),
    MesPreferences.route: (context) => MesPreferences(),
    NvxMdp.route: (context) => NvxMdp()
  };
}
