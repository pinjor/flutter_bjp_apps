import 'package:bjp_app/core/database/sub_district.dart';

final Map<String, String> districtMap = {
  // বরিশাল বিভাগ
  'বরিশাল': '80dc1b41-f32f-414f-aaa6-63354000549b',
  'বরগুনা': '2a4c157a-0016-476c-bd65-3d14b519ea10',
  'ভোলা': '9626d329-58c3-4ccd-8260-679e5a61b74b',
  'ঝালকাঠি': '198d591d-2ab6-4093-a687-b6979e9941e0',
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

  //ময়মনসিংহ
  districtMap['ময়মনসিংহ']!: [
    SubDistrict(id: '86c40cba-3254-4755-a672-7991960bd812', name: 'ভালুকা'),
    SubDistrict(id: '4dbf5c05-0a53-431c-911e-66cfc01487ef', name: 'ধোবাউড়া'),
    SubDistrict(
      id: 'd66825e5-76fe-437c-bae2-a5ce652458d8',
      name: 'ফুলবাড়িয়া',
    ),
    SubDistrict(id: 'ed810688-101f-4f73-8659-44e5808243b6', name: 'ত্রিশাল'),
    SubDistrict(id: '08da8c21-95b2-4b4c-b94a-889a3eab1f45', name: 'মুক্তাগাছা'),
    SubDistrict(
      id: '88d1a778-6fdd-42aa-87a4-ee6fb381ad6f',
      name: 'ময়মনসিংহ সদর',
    ),
    SubDistrict(id: 'f5b94689-bacf-47a7-8ac4-1e4fa2107a6c', name: 'ফুলপুর'),
    SubDistrict(id: '1280c3d8-442e-4ad3-91ee-3af247d71e4a', name: 'হালুয়াঘাট'),
    SubDistrict(id: '0d289df0-aa30-4913-93cc-6edc15a7c4e0', name: 'গৌরীপুর'),
    SubDistrict(id: 'cfcbc974-2ef0-48d8-a7b5-e98b4d7bfbe5', name: 'গফরগাঁও'),
    SubDistrict(id: 'fca8e536-bfd1-4540-9292-f796d27bbd68', name: 'ঈশ্বরগঞ্জ'),
    SubDistrict(id: '3e561a43-678a-40e1-9ad7-ce1005dd6675', name: 'নান্দাইল'),
    SubDistrict(id: '3a04772d-5068-43ae-984a-d688a422fc41', name: 'তারাকান্দা'),
  ],

  //জামালপুর
  districtMap['জামালপুর']!: [
    SubDistrict(
      id: '35929d33-62dc-4c16-a03d-d55b2563f73b',
      name: 'জামালপুর সদর',
    ),
    SubDistrict(id: '6ef30ca7-c031-49dc-aebb-d439ebb1b3fa', name: 'মেলান্দহ'),
    SubDistrict(id: '5d7f06f3-d04f-4c9a-8d8f-51e933e18231', name: 'ইসলামপুর'),
    SubDistrict(
      id: 'a3686f52-c8b1-4bf5-a661-26675363291c',
      name: 'দেওয়ানগঞ্জ',
    ),
    SubDistrict(id: '5846e8ab-849b-4694-879c-18e27cf3dff2', name: 'সরিষাবাড়ী'),
    SubDistrict(id: '134b4265-6e14-439c-963e-555c99ea0941', name: 'মাদারগঞ্জ'),
    SubDistrict(id: '6cd91e88-e8ee-4a0e-8617-0e798f152353', name: 'বকশীগঞ্জ'),
  ],

  //নেত্রকোনা
  districtMap['নেত্রকোনা']!: [
    SubDistrict(id: '86c40cba-3254-4755-a672-7991960bd812', name: 'বারহাট্টা'),
    SubDistrict(id: '4dbf5c05-0a53-431c-911e-66cfc01487ef', name: 'দুর্গাপুর'),
    SubDistrict(id: 'd66825e5-76fe-437c-bae2-a5ce652458d8', name: 'কেন্দুয়া'),
    SubDistrict(id: 'ed810688-101f-4f73-8659-44e5808243b6', name: 'আটপাড়া'),
    SubDistrict(id: '08da8c21-95b2-4b4c-b94a-889a3eab1f45', name: 'মদন'),
    SubDistrict(
      id: 'f5b94689-bacf-47a7-8ac4-1e4fa2107a6c',
      name: 'খালিয়াজুরী',
    ),
    SubDistrict(id: '1280c3d8-442e-4ad3-91ee-3af247d71e4a', name: 'কলমাকান্দা'),
    SubDistrict(id: '0d289df0-aa30-4913-93cc-6edc15a7c4e0', name: 'মোহনগঞ্জ'),
    SubDistrict(id: 'cfcbc974-2ef0-48d8-a7b5-e98b4d7bfbe5', name: 'পূর্বধলা'),
    SubDistrict(
      id: '88d1a778-6fdd-42aa-87a4-ee6fb381ad6f',
      name: 'নেত্রকোনা সদর',
    ),
  ],

  //শেরপুর
  districtMap['শেরপুর']!: [
    SubDistrict(id: '0ffa6a76-cae2-4a75-a656-3db983db9f84', name: 'শেরপুর সদর'),
    SubDistrict(
      id: '29206e29-e730-494a-bbbe-59be7326c300',
      name: 'নালিতাবাড়ী',
    ),
    SubDistrict(id: 'edaf2fd7-1f83-4cb5-a5ed-b58ac66ccb9d', name: 'শ্রীবর্দী'),
    SubDistrict(id: 'ac746b29-8e77-4262-9640-554b7832dc06', name: 'নোকলা'),
    SubDistrict(id: 'd199b1ff-490c-4e50-972a-96f02594ed97', name: 'ঝিনাইগাতী'),
  ],

  //হবিগঞ্জ
  districtMap['হবিগঞ্জ']!: [
    SubDistrict(id: '72b85cd1-2bd7-42c1-8941-28f6702d2f55', name: 'নবীগঞ্জ'),
    SubDistrict(id: '14143862-368d-49af-bc82-ca5e58e6c8dc', name: 'বাহুবল'),
    SubDistrict(id: 'fba7a720-c078-42fa-89b2-c8a6a9d017de', name: 'বানিয়াচং'),
    SubDistrict(id: '29e40afe-e9fb-45cf-aa9d-8db42af2360f', name: 'আজমিরীগঞ্জ'),
    SubDistrict(id: '3def2a9d-c482-4579-99b0-de5794f8e649', name: 'লাখাই'),
    SubDistrict(id: '30e67f22-d3d4-4423-bb28-49bf92f39730', name: 'চুনারুঘাট'),
    SubDistrict(
      id: 'aa2dd317-9fe9-46cd-8215-06a0fd6e849e',
      name: 'হবিগঞ্জ সদর',
    ),
    SubDistrict(id: '34cfe8ac-3966-41b2-b406-6a7b05e662e7', name: 'মাধবপুর'),
  ],

  //মৌলভীবাজার
  districtMap['মৌলভীবাজার']!: [
    SubDistrict(id: 'a3bb2307-1f5f-4fec-a331-a6c6b31f5920', name: 'বড়লেখা'),
    SubDistrict(id: '40c43cfb-a1be-46b5-a7b6-7d9c9f1ee173', name: 'কমলগঞ্জ'),
    SubDistrict(id: 'efba7fd1-539c-43e7-a55f-9e52ba7015cc', name: 'কুলাউড়া'),
    SubDistrict(
      id: '774023a1-7c10-4bd2-bc3c-1f36a9a90f4a',
      name: 'মৌলভীবাজার সদর',
    ),
    SubDistrict(id: '6884c1ac-f800-4882-8e05-0c71ff140437', name: 'রাজনগর'),
    SubDistrict(id: '2550a458-6df6-4cd5-94d2-bac318e37921', name: 'শ্রীমঙ্গল'),
    SubDistrict(id: '450149bf-ebf4-435c-9003-97cb5154a7f2', name: 'জুরি'),
  ],

  //সুনামগঞ্জ
  districtMap['সুনামগঞ্জ']!: [
    SubDistrict(
      id: '607d8d03-ab92-44fa-bf66-1ee24e77a6dd',
      name: 'সুনামগঞ্জ সদর',
    ),
    SubDistrict(
      id: 'b6521b56-3b06-4b8c-b6bd-85f6b1dd9b73',
      name: 'দক্ষিণ সুনামগঞ্জ',
    ),
    SubDistrict(
      id: 'adef04c3-f4c1-4da4-8658-bedd1dd049d4',
      name: 'বিশ্বম্ভরপুর',
    ),
    SubDistrict(id: 'b2ea7089-1e0b-4c52-bdf9-c87a1bccf888', name: 'ছাতক'),
    SubDistrict(id: 'bff42c30-bd1f-4571-98bb-788ab3e2d43e', name: 'জগন্নাথপুর'),
    SubDistrict(
      id: '622ddfa4-97c0-4e66-815d-bf5fb35f3e58',
      name: 'দোয়ারাবাজার',
    ),
    SubDistrict(id: '9e8f2acb-7f71-4fc0-b2a8-31efb0fae81c', name: 'তাহিরপুর'),
    SubDistrict(id: '1628891c-3031-4cff-a0b4-ee56345ffa28', name: 'ধর্মপাশা'),
    SubDistrict(id: 'b4068d61-2cc7-4e0d-9284-8f384828d276', name: 'জামালগঞ্জ'),
    SubDistrict(id: 'cb59ca9e-3ae9-4107-b652-27f9d16a5f7c', name: 'শাল্লা'),
    SubDistrict(id: '9e65189a-fc71-43ef-8bc0-387c5439b206', name: 'ডেরাই'),
  ],

  //সিলেট
  districtMap['সিলেট']!: [
    SubDistrict(id: '33519949-d018-47ff-9dae-680584df637e', name: 'বালাগঞ্জ'),
    SubDistrict(
      id: '97bf65a9-b153-4317-90eb-66d797a962f4',
      name: 'বিয়ানীবাজার',
    ),
    SubDistrict(id: 'fe0cd3f1-1b49-48bc-b59c-e4cf6fdfd441', name: 'বিশ্বনাথ'),
    SubDistrict(
      id: '2fb53daf-86db-4338-8da5-24ddc45585d1',
      name: 'কোম্পানীগঞ্জ',
    ),
    SubDistrict(id: '76f8a014-a269-4a20-9c7e-09614e82669c', name: 'ফেঞ্চুগঞ্জ'),
    SubDistrict(id: 'cfd4db54-6c1a-4096-8b99-2e9ba13c34cb', name: 'গোলাপগঞ্জ'),
    SubDistrict(id: '465d37e1-380c-4e9b-a124-a7c5c85e280f', name: 'গোয়াইনঘাট'),
    SubDistrict(id: '6b33ba9f-a4a1-420b-8785-9a3fcaeca05e', name: 'জৈন্তাপুর'),
    SubDistrict(id: 'f2ddd5b5-e6e2-4d5c-a4ec-f2d18368f9bf', name: 'কানাইঘাট'),
    SubDistrict(id: '7c2c63b8-ae3b-45f0-bfcf-4935754055f3', name: 'সিলেট সদর'),
    SubDistrict(id: '8ac0cef7-e691-412a-ba0a-8e9d7e2872fc', name: 'জকিগঞ্জ'),
    SubDistrict(
      id: '5d043201-2af8-4d73-b8e9-71e066bcea5d',
      name: 'দক্ষিণসুরমা',
    ),
    SubDistrict(id: '70e50f2b-1137-4c4a-8b84-0fcdb13aeb69', name: 'ওসমানীনগর'),
  ],

  //বরিশাল
  districtMap['বরিশাল']!: [
    SubDistrict(id: 'a58a91ea-67b1-4e2b-9191-578c7b73a899', name: 'আগাইলঝাড়া'),
    SubDistrict(id: '74541126-6159-4420-b316-69549a31c526', name: 'বাবুগঞ্জ'),
    SubDistrict(id: '127db652-822c-4b25-97ef-30c874add68f', name: 'বাকেরগঞ্জ'),
    SubDistrict(id: '21602621-e45f-4296-ab99-e619c6101747', name: 'বরিশাল সদর'),

    SubDistrict(id: 'f40a090e-5543-4a3e-97c8-d7277f534da7', name: 'উজিরপুর'),
    SubDistrict(
      id: '60c5caf4-d940-415e-92d8-8519a2c3891c',
      name: 'বানারীপাড়া',
    ),
    SubDistrict(id: '2913aba5-190b-4eb6-9ab2-b010c27f7c1a', name: 'গৌরনদী'),

    SubDistrict(
      id: 'c1537090-3833-4574-bf4c-53627e7f1cc1',
      name: 'মেহেন্দিগঞ্জ',
    ),
    SubDistrict(id: 'ec6172e1-ee18-479d-a0e4-86110f951366', name: 'মুলাদি'),
    SubDistrict(id: 'f4391f68-8b5c-4821-be53-8fdd7e6751c2', name: 'হিজলা'),
  ],




  //বরগুনা
  districtMap['বরগুনা']!: [
    SubDistrict(id: '3d42592c-a176-4fbd-b5e7-15a5348e5e87', name: 'আমতলী'),
    SubDistrict(id: '986b31f0-8324-4ef6-9f0d-716cbfa15200', name: 'বরগুনা সদর'),

    SubDistrict(id: '029c015e-0d7c-4177-96bc-4e8fdb07907d', name: 'বেতাগী'),
    SubDistrict(
      id: 'f0e2bf52-e21a-4033-a872-dae52314ba48',
      name: 'বামনা',
    ),
    SubDistrict(id: '38d001a6-6762-485f-bc3d-e3d7242fca4c', name: 'পাথরঘাটা'),

    SubDistrict(
      id: '329f0836-bd56-4d0d-a3cd-d048bbf3782a',
      name: 'তালতলী',
    ),

  ],

  //ভোলা
  districtMap['ভোলা']!: [
    SubDistrict(id: 'f066da3e-4814-4e44-b546-b134f6fe2f46', name: 'ভোলা সদর'),

    SubDistrict(id: '08a14117-2bbd-4db7-9efe-e0252eab7f09', name: 'বোরহান উদ্দিন'),
    SubDistrict(
      id: '561c09bc-6dc8-48df-a8d9-6fb04db37d851c',
      name: 'চরফ্যাসন',
    ),
    SubDistrict(id: '08e8edb5-0124-4424-b83b-932e50e0e196', name: 'দৌলতখান'),

    SubDistrict(
      id: '5fdb4eff-363c-4910-82be-2907888c7d93',
      name: 'মনপুরা',
    ),
    SubDistrict(
      id: '3d10398c-2bcf-4001-8f24-cd68f005b540',
      name: 'তজুমদ্দিন',
    ),
    SubDistrict(
      id: '31db7011-8e3d-41c5-8ebc-cf00bee8392e',
      name: 'লালমোহন',
    ),
  ],


  //ঝালকাঠি
  districtMap['ঝালকাঠি']!: [
    SubDistrict(id: '3ab85114-0a60-4ca9-80e3-91dd747de85e', name: 'ঝালকাঠি সদর'),

    SubDistrict(id: '5dc84564-a364-409d-b9ac-b68096d2d9bb', name: 'কাঁঠালিয়া'),
    SubDistrict(
      id: 'dcda4ca9-67e3-420d-8cc5-1fd51f479755',
      name: 'নলছিটি',
    ),
    SubDistrict(id: 'e99fb463-84a2-4f33-a684-f4d65ada2631', name: 'রাজাপুর'),

  ],


  //পটুয়াখালী
  districtMap['পটুয়াখালী']!: [
    SubDistrict(id: '4521ba72-9963-42b6-bc92-5fc22353a566', name: 'বাউফল'),
    SubDistrict(id: '79755bb2-5fc7-4074-a851-cd2e5716a80b', name: 'পটুয়াখালী সদর'),
    SubDistrict(
      id: '1570943b-374b-486c-9d2c-e6e2717ef68a',
      name: 'দুমকি',
    ),
    SubDistrict(id: 'cb51abe8-1267-400e-876a-2e42bb77fe96', name: 'দশমিনা'),
    SubDistrict(
      id: 'a1f330ab-0720-4800-b394-2d108041c821',
      name: 'কলাপাড়া',
    ),
    SubDistrict(id: '32bfb3ee-333f-4535-8e2f-fdef7873ffd6', name: 'মির্জাগঞ্জ'),
    SubDistrict(
      id: 'c9b8bce6-3155-47db-846b-7dd5068f84fd',
      name: 'গলাচিপা',
    ),
    SubDistrict(id: 'f8381911-1b96-472d-8197-66a5eb10c956', name: 'রাঙ্গাবালি'),

  ],



  //পিরোজপুর
  districtMap['পিরোজপুর']!: [
    SubDistrict(id: '1d881bac-e682-4c9a-8fc3-bacb8eecff53', name: 'পিরোজপুর সদর'),

    SubDistrict(id: 'ad23ec6a-e855-4776-9631-70d83ad07a3e', name: 'নাজিরপুর'),
    SubDistrict(
      id: 'fe1a5dc7-5735-40d0-b201-f75b8597c192',
      name: 'কাউখালী',
    ),
    SubDistrict(id: '4d7cd751-d4db-4496-b461-26560546e1b6', name: 'জিয়ানগর'),
    SubDistrict(id: '8a03adce-6afa-4cac-97cb-6af3c9340f34', name: 'ভান্ডারিয়া'),
    SubDistrict(
      id: '28af7190-dca0-40b0-9ca0-c3e6264491f4',
      name: 'মঠবাড়িয়া',
    ),
    SubDistrict(id: '3af07cd5-5909-4dd6-a4d9-f9909c23a4df', name: 'নেছারাবাদ'),

  ],




  //ব্রাহ্মণবাড়িয়া
  districtMap['ব্রাহ্মণবাড়িয়া']!: [
    SubDistrict(
      id: '11a669ca-08f3-41e5-8c3d-c732d6d36ea8',
      name: 'আখাউড়া',
    ),
    SubDistrict(id: 'cd8430a5-c047-492b-8cca-447ec60ac9b3', name: 'আশুগঞ্জ'),
    SubDistrict(
      id: '99167e21-5400-478a-a621-5d23fd61f766',
      name: 'বাঞ্ছারামপুর',
    ),
    SubDistrict(id: 'c4f04ee2-94f6-4dcd-8b7c-64ab26a6ea1f', name: 'ব্রাহ্মণবাড়িয়া সদর'),
    SubDistrict(
      id: 'fb31b76f-5156-4de1-a199-ca0d688bec39',
      name: 'কসবা',
    ),
    SubDistrict(
      id: 'd430255a-d8d8-4751-be13-dde00da801a0',
      name: 'নাসিরনগর',
    ),
    SubDistrict(id: '55b4e98c-9561-4069-a5bf-bf9dd542bd13', name: 'সরাইল'),
    SubDistrict(
      id: 'a7555623-41d1-46f0-a687-485ca3c7cbdd',
      name: 'নবীনগর',
    ),
    SubDistrict(id: 'f94e2971-f7d6-436d-873a-fb316baf6541', name: 'বিজয়নগর'),
  ],

//কুমিল্লা
  districtMap['কুমিল্লা']!: [
    SubDistrict(
      id: '2f533bcc-d796-45af-9e42-3dbfe3c9ba49',
      name: 'দেবিদ্বার',
    ),
    SubDistrict(id: 'd1a6b112-4ffc-4bd9-9c34-6aeb1b2efe95', name: 'বরুড়া'),
    SubDistrict(
      id: 'ca433d67-a660-4c02-8fa5-dd70da471c29',
      name: 'ব্রাহ্মণপাড়া',
    ),
    SubDistrict(
      id: '0c5f43d4-64d6-4ca6-8434-37efadca9514',
      name: 'চান্দিনা',
    ),
    SubDistrict(
      id: 'e64ec461-0d8b-4b5a-b282-aed7575d32f0',
      name: 'চৌদ্দগ্রাম',
    ),
    SubDistrict(id: 'd34d14b3-70ba-4bb5-b892-a126658dba3e', name: 'দাউদকান্দি'),
    SubDistrict(
      id: '36fa48c6-33f5-470d-87b4-73ae031a9551',
      name: 'হোমনা',
    ),
    SubDistrict(
      id: 'c842eb45-a41a-44a7-a17f-3b968f0bc3fd',
      name: 'লাকসাম',
    ),
    SubDistrict(id: '7c970fe6-0f09-4f38-954f-1b6193b8322c', name: 'মুরাদনগর'),
    SubDistrict(
      id: 'b4a94f9c-ba47-43ef-aeee-24b3b6a065f8',
      name: 'নাঙ্গলকোট',
    ),
    SubDistrict(id: 'afad4e66-5e8c-48b5-b309-49b5c1f474d4', name: 'কুমিল্লা সদর'),
    SubDistrict(
      id: '082720eb-e646-4793-bf30-995052ca6b96',
      name: 'মেঘনা',
    ),
    SubDistrict(
      id: 'cf1923aa-6427-46eb-961a-5e74022c0646',
      name: 'মনোহরগঞ্জ',
    ),
    SubDistrict(id: '6ead7af4-9e2d-4cb8-98ab-aa02905a6519', name: 'সদরদক্ষিণ'),
    SubDistrict(
      id: '7dd966c0-d132-4917-8824-c4e860728abd',
      name: 'তিতাস',
    ),
    SubDistrict(id: 'e82cf44a-4296-456b-91e0-8c2962abd2d6', name: 'বুড়িচং'),
    SubDistrict(id: '810eb410-ed59-4b34-8f6f-a667b7b118dc', name: 'লালমাই'),
  ],


  //চাঁদপুর
  districtMap['চাঁদপুর']!: [
    SubDistrict(id: 'e3646d2e-f7a7-4fbc-970c-ffe3c60050d3', name: 'হাইমচর'),
    SubDistrict(
      id: 'f7c1c96c-5f70-432f-8150-1c1e764060a4',
      name: 'কচুয়া',
    ),
    SubDistrict(id: '217f9f93-5a47-4172-8c0b-52da0fa68a21', name: 'শাহরাস্তি'),
    SubDistrict(id: 'a7d66695-2c24-4f68-9567-3b97cb783b3d', name: 'চাঁদপুর সদর'),
    SubDistrict(
      id: '74284ff2-4221-470b-afed-dfb2cf276ba7',
      name: 'মতলব দক্ষিণ',
    ),
    SubDistrict(id: 'c4940898-791f-4a16-8bfb-518f27b84f6d', name: 'হাজীগঞ্জ'),
    SubDistrict(
      id: 'cd8843c2-3b33-4282-9c3d-5664185ff385',
      name: 'মতলব উত্তর',
    ),
    SubDistrict(id: '18681c9f-5d6e-4f41-ae63-168d2e35b311', name: 'ফরিদগঞ্জ'),
  ],

//লক্ষ্মীপুর
  districtMap['লক্ষ্মীপুর']!: [
    SubDistrict(id: 'e11cd5cb-379b-4913-9fa1-676d42c485cd', name: 'লক্ষ্মীপুর সদর'),

    SubDistrict(id: '5942419a-3ed2-449d-98d5-8067eca8b952', name: 'কমলনগর'),
    SubDistrict(
      id: '82549570-fb87-4259-b26c-f604d5bd63db',
      name: 'রায়পুর',
    ),
    SubDistrict(id: '073ae979-7c65-4660-a664-cdebf1420094', name: 'রামগতি'),
    SubDistrict(id: 'b182568a-95dd-4af6-9813-78bae1a67d87', name: 'রামগঞ্জ'),
  ],

};
