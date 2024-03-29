import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:tumbaspedia_seller/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:tumbaspedia_seller/models/models.dart';
import 'package:tumbaspedia_seller/services/services.dart';
import 'package:tumbaspedia_seller/shared/shared.dart';
import 'package:tumbaspedia_seller/ui/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:supercharged/supercharged.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sweetalert/sweetalert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

part 'general_page.dart';

part 'add_shop_page.dart';

part 'add_product_page.dart';

// part 'add_nib_page.dart';
part 'sign_in_page.dart';

part 'sign_up_page.dart';

part 'main_page.dart';

part 'home_page.dart';

part 'product_details_page.dart';

part 'profile_page.dart';

part 'edit_product_page.dart';

part 'edit_shop_page.dart';

part 'product_page.dart';

part 'illustration_page.dart';

part 'success_sign_up_page.dart';

part 'success_sign_in_page.dart';

part 'order_history_page.dart';

part 'transaction_details_page.dart';

// part 'edit_transaction_page.dart';
part 'waiting_shop_page.dart';

part 'forgot_password_page.dart';

part 'change_password_page.dart';

part 'upload_page.dart';

part 'all_reviews_page.dart';

part 'tumbaspedia/payment_instructions_page.dart';

part 'tumbaspedia/help_page.dart';

part 'tumbaspedia/privacy_page.dart';

part 'tumbaspedia/security_page.dart';

part 'tumbaspedia/term_page.dart';

part 'tumbaspedia/about_page.dart';
