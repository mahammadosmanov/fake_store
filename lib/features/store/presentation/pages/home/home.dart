import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/store/domain/entities/product_entity.dart';
import 'package:test_task/features/store/presentation/pages/home/bloc/home_bloc.dart';
import 'package:test_task/features/store/presentation/pages/home/bloc/switch_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffEDEDED),
          appBar: AppBar(
            shape: const BorderDirectional(
              bottom: BorderSide(
                width: 4,
                color: Colors.black,
              ),
            ),
            title: Text(
              tr("store"),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ),
          drawer: _buildDrawer(context),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state is HomeInitial) const Spacer(),
                if (state is HomeInitial)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (state is HomeSet)
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 3,
                        bottom: 60,
                      ),
                      itemCount: state.productList.length,
                      itemBuilder: (context, index) {
                        return _buildProduct(
                          title: state.productList[index].title ?? '',
                          price: state.productList[index].price.toString(),
                          description:
                              state.productList[index].description ?? '',
                          category: state.productList[index].category ?? '',
                          image: state.productList[index].image ?? '',
                          rating: state.productList[index].rating?.rate
                                  .toString() ??
                              '',
                        );
                      },
                    ),
                  ),
                if (state is HomeInitial) const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    tr("filters"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ...ProductCategory.values.map(
                (category) => ListTile(
                  leading: Switch(
                    value: (state is SwitchedState)
                        ? state.productCategoryList.contains(
                            category,
                          )
                        : true,
                    onChanged: (value) {
                      context.read<SwitchBloc>().add(
                            Filter(productCategory: category),
                          );
                      context.read<HomeBloc>().add(
                            const FilterEvent(),
                          );
                    },
                  ),
                  title: Text(
                    tr(
                      category.name,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProduct({
    required String title,
    required String price,
    required String description,
    required String category,
    required String image,
    required String rating,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 5,
              ),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    child: Text(
                      "$price\$",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 32,
                    ),
                    Text(
                      " $rating",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                  description,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
