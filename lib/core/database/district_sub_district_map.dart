import 'package:bjp_app/core/database/sub_district.dart';

final Map<String, String> districtMap = {
  // বরিশাল বিভাগ
  'বরিশাল': '80dc1b41-f32f-414f-aaa6-63354000549b',
  'বরগুনা': '2a4c157a-0016-476c-bd65-3d14b519ea10',
  'ভোলা': '9626d329-58c3-4ccd-8260-679e5a61b74b',
  'ঝালোকাটি': '198d591d-2ab6-4093-a687-b6979e9941e0',
  'পটুয়াখালী': '78c4180f-d9c5-40be-8d1d-f60fc91af586',
  'পিরোজপুর': 'e12bcfef-1ccc-4012-8eda-08e222965fbd',

  // চট্টগ্রাম বিভাগ
  'ব্রাহ্মণবাড়িয়া': '31e97adf-159f-42a7-ad59-af8f72fa0eab',
  'কুমিল্লা': 'f5c95e6f-d8a4-477f-8bd6-4e33a8e8739c',
  'চাঁদপুর': 'e7b5abeb-f5b5-43d3-84c3-0c7f56cb6dda',
  'লক্ষ্মীপুর': '0290ea70-ce3f-427f-addc-429345825f34',
  'নোয়াখালী': 'b14d0d4b-750c-420e-8ec4-0f45e168493c',
  'ফেনী': '582b0c08-573a-437b-a4e9-24d85b65ef2e',
  'খাগড়াছড়ি': '8ea331d3-779e-4c37-8db9-56426187ef23',
  'রাঙ্গামাটি': '045ac952-92a6-4272-8bb8-d5d06996520b',
  'বন্দরবান': '1838bb2e-2afa-4b39-80e2-9b6faffd2e14',
  'চট্টগ্রাম': '1fbd0359-d3d1-4a46-8eae-5ecb897b4d2c',
  'কক্সবাজার': 'b826a067-7c91-48b5-99b7-aa3d0498a243',

  // ঢাকা বিভাগ
  'ঢাকা': '0bc234e0-3bf7-40bb-beb2-97de020d2468',
  'গাজীপুর': '08c5efa8-4fec-42b5-bc65-d6cf74fe07ea',
  'কিশোরগঞ্জ': '3eb69540-c877-4f09-831b-78b9dd962be0',
  'মানিকগঞ্জ': '230d12d3-f3bc-4ba9-a2dc-7db16b063798',
  'মুন্সিগঞ্জ': '06416f7a-d867-425a-a50f-1b8da64e09f9',
  'নারায়ণগঞ্জ': 'c9f1e1b6-bab6-4e87-890f-fe43080cb250',
  'নরসিংদি': '25d9a8be-559b-4ea7-9ec6-58eccf51a161',
  'টাঙ্গাইল': '8c1321a8-4164-4097-9b3a-39f100082f15',
  'ফরিদপুর': 'd4e5d5d5-97e9-4b80-936a-1a336139a9da',
  'গোপালগঞ্জ': '203839ad-5541-4e5f-8912-cd61b8c71023',
  'মাদারীপুর': 'ae728fae-8127-4009-b932-e8c592bb5e31',
  'রাজবাড়ি': '1728e448-5d7c-48e9-81dc-075b03a42878',
  'শরীয়তপুর': '30ddde4c-5cca-4dba-856c-5366b8616746',

  // খুলনা বিভাগ
  'খুলনা': '2806e73e-b618-40f2-8b99-b880a423e6f7',
  'সাতক্ষীরা': '63756d04-d2b8-4e6e-a411-5284ce7ca36c',
  'যশোর': '48a83988-029a-4cdb-aa0a-f34304fdfbdd',
  'ছুয়াডাঙ্গা': 'ce22cd15-01ef-467a-a827-028b24194e78',
  'ঝিনাইদহ': '6030b724-4063-4f99-830a-fb0c2109a8ad',
  'কুষ্টিয়া': 'df8d3748-b00c-4dd0-adfa-593417c5709d',
  'মাগুরা': 'e0a88ac7-9f7a-489a-bae8-b87140d4e493',
  'মেহেরপুর': '833fc003-04c6-47b7-a916-b873dcbd9e40',
  'নারাইল': 'a07a8990-278d-4360-afb3-116b72f2e7da',
  'বাগেরহাট': '9fbe2a17-715d-4a5c-820c-f98dc3f3aadb',

  // ময়মনসিংহ বিভাগ
  'ময়মনসিংহ': '82e2e447-c54c-4022-b677-baed010eeb20',
  'জামালপুর': '7a88bf80-344d-4be2-88ed-b6e2526d82a0',
  'নেত্রকোনা': '4404d9c9-8968-4d62-bb4a-5444c6aec358',
  'শেরপুর': 'df9181c3-f509-4dfe-ba9e-fa5559d1fbfa',

  // রাজশাহী বিভাগ
  'নাটোর': '5a41c5ff-27eb-4832-bea4-437db20d2c2c',
  'রাজশাহী': '4e904d43-2799-4a4f-9e23-f2cb32ae0199',
  'সিরাজগঞ্জ': '1bb79c90-a70d-432e-80ee-9d4e0e32a820',
  'পাবনা': '26f185f7-5b54-4c0e-b496-b19a53e98383',
  'বগুড়া': '9bc9fcf9-a8ae-446b-ad57-ef4dd2c7399d',
  'চাপাইনবাবগঞ্জ': '6792a399-f5fe-4ed0-8352-3acf12283f99',
  'নওগাঁ': '2d8442fa-17a5-4696-a811-c9488ee14eca',
  'জয়পুরহাট': '27ece738-b583-4950-83a1-4c2a83415f4c',

  // রংপুর বিভাগ
  'দিনাজপুর': '36b45df7-7a04-4bff-bd94-51f7513dfd17',
  'কুড়িগ্রাম': '8314769a-699f-453d-9bf4-2cf5d4b47bbc',
  'গাইবান্ধা': 'db24d25d-e2af-4794-952b-bd99ae3070bb',
  'লালমনিরহাট': '2de7ee96-e7d9-494a-a2df-03106d74a279',
  'নিলফামারি': '95163516-8f2f-41ee-8a70-c97142b35475',
  'পঞ্চগড়': 'd5b09373-4def-4336-b228-92218ae18c50',
  'রংপুর': '933758b9-f830-4425-be3f-152cdb07d715',
  'ঠাকুরগাঁও': '16b7f796-98fa-4643-a2d6-c27c82aafdce',

  // সিলেট বিভাগ
  'হবিগঞ্জ': 'e2c6d245-9eeb-4c84-a2b0-050548f77351',
  'মৌলভীবাজার': 'e1f0ea51-82ee-4369-a894-b9daba60087c',
  'সুনামগঞ্জ': '583085fd-be05-4e93-845c-fde8dbec0ede',
  'সিলেট': 'bddd5326-2f95-4a8f-991a-c24125cc6b22',
};

final Map<String, List<SubDistrict>> districtSubdistrictMap = {
  // ঢাকা জেলা
  districtMap['ঢাকা']!: [
    SubDistrict(id: '17364690-189f-44f1-a2be-213fd9e184fd', name: 'নবাবগঞ্জ'),
    SubDistrict(id: '7b948ada-e2a7-4a68-9633-e23f337204e3', name: 'সাভার'),
    SubDistrict(id: 'e8fd22e5-06db-4b53-b926-da5f6b3590d0', name: 'কেরাণীগঞ্জ'),
    SubDistrict(id: '0752b05c-548d-45c8-bbed-95079fae702a', name: 'দোহার'),
    SubDistrict(id: 'c9f5cdb1-4589-4958-944a-6786de7a2468', name: 'ধামরাই'),
  ],
  // গাজীপুর জেলা
  districtMap['গাজীপুর']!: [
    SubDistrict(id: '82b94d13-f394-4bab-a3f8-b146ce3c2721', name: 'শ্রীপুর'),
    SubDistrict(id: 'a9339186-165c-4023-b284-82c104e88d9c', name: 'কাপাসিয়া'),
    SubDistrict(id: 'cab9d385-598b-4b1d-a664-d747ba1c7e38', name: 'কালিগঞ্জ'),
    SubDistrict(id: '1a464e15-ed11-41a1-bd12-560d6d236a27', name: 'কালিয়াকৈর'),
    SubDistrict(
      id: '925cb563-1872-457d-aba1-687d19cad4b0',
      name: 'গাজীপুর সদর',
    ),
  ],

  //কিশোরগঞ্জ
  districtMap['কিশোরগঞ্জ']!: [
    SubDistrict(id: '6c531adc-d7d2-498f-95e6-81dd77d2154f', name: 'অষ্টগ্রাম'),
    SubDistrict(id: '384220f6-dff5-43ba-8e6a-983a81dda01e', name: 'বাজিতপুর'),
    SubDistrict(id: '6990fb59-c6af-4c2c-999b-072493c77631', name: 'ভৈরব'),
    SubDistrict(id: 'f04b738d-f085-44ea-bdb5-7aec706cff81', name: 'ইতনা'),
    SubDistrict(id: '35418fba-0a1f-4608-b780-c5cf5dcf66e4', name: 'কটিয়াদি'),
    SubDistrict(id: 'c999b66e-d458-46d4-8ce2-d6486a594785', name: 'তাড়াইল'),
    SubDistrict(id: 'd325897b-2007-4b2a-8ed7-4880c1998cc3', name: 'হোসেনপুর'),
    SubDistrict(
      id: '0d7c46d0-863c-4ec1-9928-bd3cb7db690b',
      name: 'পাকুন্দিয়া',
    ),
    SubDistrict(id: '35f0a3e9-5df1-409d-895d-da7923fd8868', name: 'কুলিয়ারচর'),
    SubDistrict(
      id: 'c1f1ab90-ea5f-4b58-842a-184906bd005f',
      name: 'কিশোরগঞ্জ সদর',
    ),
    SubDistrict(id: '94eaf049-5f0b-43cb-a324-fd3abcb4887c', name: 'করিমগঞ্জ'),
    SubDistrict(id: 'e4a592a8-4673-4b25-b212-d6ea694bf59e', name: 'মিঠামোইন'),
    SubDistrict(id: 'a22a43ef-97c5-4068-a733-230ffb523be2', name: 'নিকলি'),
  ],

  //মানিকগঞ্জ
  districtMap['মানিকগঞ্জ']!: [
    SubDistrict(id: '0dade580-8981-4b58-b421-5fcf59ab22f5', name: 'দৌলতপুর'),
    SubDistrict(id: '6cf7e762-9181-497b-beff-6df8fca8714a', name: 'জিওর'),
    SubDistrict(id: '0e0105c8-ffa7-4543-966f-01e6bb0e8c78', name: 'সাটুরিয়া'),
    SubDistrict(
      id: '4f4ed602-e804-422e-a2f5-9315c16a98c2',
      name: 'মানিকগঞ্জ সদর',
    ),
    SubDistrict(id: '06684a08-f0ea-4445-b256-747ef93ffe8d', name: 'শিবালয়'),
    SubDistrict(id: '5dd6b404-a2f4-4b67-b657-4b801407efd7', name: 'সিঙ্গিয়ার'),
    SubDistrict(id: 'b1e402ee-d549-4e49-bf6a-176e7ab9f39d', name: 'হরিরামপুর'),
  ],

  //মুন্সীগঞ্জ
  districtMap['মুন্সিগঞ্জ']!: [
    SubDistrict(id: '526fa0d9-64fd-4a40-935d-f2c1d85d42c5', name: 'গজারিয়া'),
    SubDistrict(id: '6552477d-5a53-4c35-846c-8277f47de12c', name: 'লৌহজং'),
    SubDistrict(
      id: '1decc8a1-9c5a-43eb-ab7d-c2bfbc30790b',
      name: 'মুন্সীগঞ্জ সদর',
    ),
    SubDistrict(id: '03ad0d82-d560-48cd-af0d-a2c9a4620b9d', name: 'শ্রীনগর'),
    SubDistrict(id: '8e0baf42-d756-4b43-a188-8d1204509d63', name: 'সিরাজদিখান'),
    SubDistrict(id: '766dd89e-23ad-4939-8b57-06fab6f376a3', name: 'টঙ্গীবাড়ি'),
  ],

  //নরসিংদি
  districtMap['নরসিংদি']!: [
    SubDistrict(id: 'a3ce1fc0-dc18-436f-b88d-f9aba184f4e9', name: 'বেলাবো'),
    SubDistrict(id: 'da0ff8ce-0625-4db1-a165-ba68e569db48', name: 'মনোহরদী'),
    SubDistrict(
      id: '3f8f1ffa-6c82-4184-bd98-eb58f1cd8686',
      name: 'নরসিংদি সদর',
    ),
    SubDistrict(id: 'bb4e522d-5906-4ae1-b1f7-8e1539ff9312', name: 'পলাশ'),
    SubDistrict(id: '3596958f-cf41-46af-a5f1-991f79be0bfa', name: 'রায়পুরা'),
    SubDistrict(id: '937a7ea2-bbe2-4f79-8b49-0f5405d7d17b', name: 'শিবপুর'),
  ],

  //নারায়ণগঞ্জ
  districtMap['নারায়ণগঞ্জ']!: [
    SubDistrict(id: '9445428e-2074-4364-9020-d72b27f7f421', name: 'আড়াইহাজার'),
    SubDistrict(id: '1473e7a1-d95d-45f6-8c25-eab365551daf', name: 'বন্দর'),
    SubDistrict(
      id: '41e31c70-308e-4a47-8c98-031555d442a5',
      name: 'নারায়ণগঞ্জ সদর',
    ),
    SubDistrict(id: '0fa22e66-79ec-4d0b-9db6-948e00911be7', name: 'রূপগঞ্জ'),
    SubDistrict(id: 'a444c1a9-dfdf-43a7-b35c-7e9b58295546', name: 'সোনারগাঁও'),
  ],

  //টাঙ্গাইল
  districtMap['টাঙ্গাইল']!: [
    SubDistrict(id: '9445428e-2074-4364-9020-d72b27f7f421', name: 'বাসাইল'),
    SubDistrict(id: '1473e7a1-d95d-45f6-8c25-eab365551daf', name: 'ভূয়াপুর'),
    SubDistrict(id: '41e31c70-308e-4a47-8c98-031555d442a5', name: 'দেলদুয়ার'),
    SubDistrict(id: '0fa22e66-79ec-4d0b-9db6-948e00911be7', name: 'ঘাটাইল'),
    SubDistrict(id: 'a444c1a9-dfdf-43a7-b35c-7e9b58295546', name: 'গোপালপুর'),
    SubDistrict(id: '9445428e-2074-4364-9020-d72b27f7f421', name: 'মধুপুর'),
    SubDistrict(id: '1473e7a1-d95d-45f6-8c25-eab365551daf', name: 'মির্জাপুর'),
    SubDistrict(id: '41e31c70-308e-4a47-8c98-031555d442a5', name: 'নাগরপুর'),
    SubDistrict(id: '0fa22e66-79ec-4d0b-9db6-948e00911be7', name: 'সখীপুর'),
    SubDistrict(
      id: 'a444c1a9-dfdf-43a7-b35c-7e9b58295546',
      name: 'টাঙ্গাইল সদর',
    ),
    SubDistrict(id: '41e31c70-308e-4a47-8c98-031555d442a5', name: 'কালিহাতী'),
    SubDistrict(id: '0fa22e66-79ec-4d0b-9db6-948e00911be7', name: 'ধনবাড়ী'),
  ],

  //ফরিদপুর
  districtMap['ফরিদপুর']!: [
    SubDistrict(id: '7ac09833-c3ef-4f3b-b6fc-f3ada672e4ad', name: 'আলফাডাঙ্গা'),
    SubDistrict(id: 'c8730a11-e5a8-4cc8-a8b4-484fdbb31dd4', name: 'ভাঙ্গা'),
    SubDistrict(id: '754a7238-d20e-4905-8a64-40b78efd10fb', name: 'বোয়ালমারী'),
    SubDistrict(
      id: 'e3927c2e-5f50-443d-b6cd-3c692e3f4cec',
      name: 'ফরিদপুর সদর',
    ),
    SubDistrict(id: 'e18e89bc-d150-4248-9963-efab6b6b7a16', name: 'সদরপুর'),
    SubDistrict(id: 'a98b466d-75b3-4135-9f95-aa9d398efacc', name: 'নগরকান্দা'),
    SubDistrict(id: '1d029954-75d3-414c-92c3-5e2c5b0119f5', name: 'চারভদ্রাসন'),
    SubDistrict(id: '0da57ab1-4158-4beb-acb9-0f391546fc6b', name: 'মধুখালী'),
    SubDistrict(id: '0ade53a0-cd51-4df9-b664-0a8c5ed0bd08', name: 'সালথা'),
  ],

  //গোপালগঞ্জ
  districtMap['গোপালগঞ্জ']!: [
    SubDistrict(
      id: 'e3927c2e-5f50-443d-b6cd-3c692e3f4cec',
      name: 'গোপালগঞ্জ সদর',
    ),
    SubDistrict(id: 'e18e89bc-d150-4248-9963-efab6b6b7a16', name: 'কাশিয়ানী'),
    SubDistrict(
      id: 'a98b466d-75b3-4135-9f95-aa9d398efacc',
      name: 'টুঙ্গিপাড়া',
    ),
    SubDistrict(
      id: '1d029954-75d3-414c-92c3-5e2c5b0119f5',
      name: 'কোটালীপাড়া',
    ),
    SubDistrict(id: '0da57ab1-4158-4beb-acb9-0f391546fc6b', name: 'মুকসুদপুর'),
  ],

  //মাদারীপুর
  districtMap['মাদারীপুর']!: [
    SubDistrict(id: '0fa22e66-79ec-4d0b-9db6-948e00911be7', name: 'কালকিনি'),
    SubDistrict(
      id: 'a444c1a9-dfdf-43a7-b35c-7e9b58295546',
      name: 'মাদারীপুর সদর',
    ),
    SubDistrict(id: '41e31c70-308e-4a47-8c98-031555d442a5', name: 'রাজোইর'),
    SubDistrict(id: '0fa22e66-79ec-4d0b-9db6-948e00911be7', name: 'শিবচর'),
  ],

  //রাজবাড়ি
  districtMap['রাজবাড়ি']!: [
    SubDistrict(
      id: 'dbc003b9-15ee-4c19-ba75-8ebc386b566e',
      name: 'বালিয়াকান্দি',
    ),
    SubDistrict(
      id: '3f7e619b-4c80-4dda-ab24-109a21e47595',
      name: 'গোয়ালন্দঘাট',
    ),
    SubDistrict(id: '89b92ba4-fce5-439a-8980-66054fbd32e3', name: 'কালুখালী'),
    SubDistrict(
      id: '331ae9b7-a7f6-4c52-9a6b-54dbe96ac539',
      name: 'রাজবাড়ী সদর',
    ),
    SubDistrict(id: 'e0d7a6fc-1fa1-4023-9a1e-b55a76702b28', name: 'পাংসা'),
  ],

  //শরীয়তপুর
  districtMap['শরীয়তপুর']!: [
    SubDistrict(id: 'dbc003b9-15ee-4c19-ba75-8ebc386b566e', name: 'ভেদরগঞ্জ'),
    SubDistrict(id: '3f7e619b-4c80-4dda-ab24-109a21e47595', name: 'ডামুড্যা'),
    SubDistrict(id: '89b92ba4-fce5-439a-8980-66054fbd32e3', name: 'গোসাইরহাট'),
    SubDistrict(
      id: '331ae9b7-a7f6-4c52-9a6b-54dbe96ac539',
      name: 'শরীয়তপুর সদর',
    ),
    SubDistrict(id: 'e0d7a6fc-1fa1-4023-9a1e-b55a76702b28', name: 'নড়িয়া'),
    SubDistrict(id: 'e0d7a6fc-1fa1-4023-9a1e-b55a76702b28', name: 'জাজিরা'),
  ],
};
