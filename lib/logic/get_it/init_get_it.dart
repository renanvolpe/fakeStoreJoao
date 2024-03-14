import 'package:fake_store_joao/data/models/profile/profile.dart';
import 'package:fake_store_joao/data/repositories/adresses_repository.dart';
import 'package:fake_store_joao/logic/bloc/delete_address/delete_address_bloc.dart';
import 'package:fake_store_joao/logic/bloc/get_list_address/get_list_addres_bloc.dart';
import 'package:fake_store_joao/logic/bloc/post_address/post_address_bloc.dart';
import 'package:fake_store_joao/logic/bloc/put_address/put_address_bloc.dart';
import 'package:fake_store_joao/logic/cubit/address_select/address_select_cubit.dart';
import 'package:get_it/get_it.dart';

final binds = GetIt.I;

class SetupBinds {
  static void setupBindsAuth() {
    //BINDS BEFORE HOME

    //auth binds
  }

  static void setupBindsHome(Profile profile) {
    //BINDS AFTER HOME

    //Profile
    if (GetIt.I.isRegistered<Profile>()) {
      GetIt.I.get<Profile>().setNewProfile(profile); // updateBind
    } else {
      GetIt.instance.registerSingleton<Profile>(profile);
    }

    //products

    //categories

    //Address
    binds.registerSingleton<AddressesRepository>(AddressesRepository(binds.get<Profile>().user.id));

    binds.registerSingleton<AddressSelectCubit>(AddressSelectCubit());

    binds.registerSingleton<GetListAddressBloc>(GetListAddressBloc(binds.get<AddressesRepository>()));
    binds.registerSingleton<PostAddressBloc>(PostAddressBloc(binds.get<AddressesRepository>()));
    binds.registerSingleton<PutAddressBloc>(PutAddressBloc(binds.get<AddressesRepository>()));
    binds.registerSingleton<DeleteAddressBloc>(DeleteAddressBloc(binds.get<AddressesRepository>()));
    //
  }
}