
import 'package:flutter/material.dart';


import '/widgets/widgets.dart';
import '/models/hotel/hotel_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.hotelModel});
  final HotelModel hotelModel;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  GlobalKey buttonInfoDetailKey = GlobalKey();
  LayerLink layerLink = LayerLink();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              InteractiveViewer(
                maxScale: 5,
                minScale: 0.01,
                
                boundaryMargin:  EdgeInsets.zero,

                child: CacheImage(
                  imageUrl: widget.hotelModel.imageUrl,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
              const Positioned(top: 20, left: 20, child: CustomBackButton()),
             
              CustomDraggleBottomSheet(hotelModel: widget.hotelModel)
            ],
          ),
        ),
      ),
    );
  }
}
