import 'package:client/accueil/hotel_page.dart';
import 'package:client/accueil/restaurant_page.dart';
import 'package:client/accueil/attractions_page.dart';
import 'package:client/espaceVoyage/historique.dart';
import 'package:client/espaceVoyage/nouveau_voyage/reserve_attractions.dart';
import 'package:client/espaceVoyage/nouveau_voyage/reserve_hotel.dart';
import 'package:client/espaceVoyage/nouveau_voyage/reserve_restaurants.dart';
import 'package:client/espaceVoyage/nouveau_voyage/start_form.dart';
import 'package:client/espaceVoyage/nouveau_voyage/submit.dart';
import 'package:client/espaceVoyage/nouveau_voyage/test_amis.dart';
import 'package:client/main.dart';
import 'package:client/profile/Mes_Amis/amishistorique_1.dart';
import 'package:client/profile/Mes_Amis/mes_amis.dart';
import 'package:client/profile/Mes_Amis/nouveauAmis.dart';
import 'package:client/profile/Mes_Preferences/mes_preferences.dart';
import 'package:client/profile/Mon_Compte/mes_reglages.dart';
import 'package:client/profile/Nvx_Mdp/nvx_mdp.dart';
import 'package:client/profile/Mon_Compte/mon_compte.dart';
import 'package:client/home.dart';

getRoutes() {
  return {
    //MonCompte.route: (context) => MonCompte(),
    MonCompte.route: (context) => MonCompte(),
    //MesAmis.route: (context) => MesAmis(),
    MesAmis.route: (context) => MesAmis(),
    NouveauAmis.route: (context) => NouveauAmis(),
    MesPreferences.route: (context) => MesPreferences(),
    NvxMdp.route: (context) => NvxMdp(),
    MesReglages.route: (context) => MesReglages(),
    HotelPage.route: (context) => HotelPage(),
    RestaurantPage.route: (context) => RestaurantPage(),
    AttractionPage.route: (context) => AttractionPage(),
    HotelPageReserv.route: (context) => HotelPageReserv(),
    FormScreen.route: (context) => FormScreen(),
    ReserveRestaurant.route: (context) => ReserveRestaurant(),
    ReserveAttraction.route: (context) => ReserveAttraction(),
    Submit.route: (context) => Submit(),
    Historique.route: (context) => Historique(),
    AuthenticationWrapper.route: (context) => AuthenticationWrapper(),
    AmisHistorique.route: (context) => AmisHistorique()
  };
}
