import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/announcement_controller.dart';

class CreateAnnouncementScreen extends ConsumerStatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState
    extends ConsumerState<CreateAnnouncementScreen> {
  final TextEditingController _nameController = TextEditingController();


  final _formKey = GlobalKey<FormState>();


  final Map<String, String> _divisionMap = {
    'ঢাকা': 'f47ea481-c504-4dc6-9bf5-350bbb200719',
    'চট্টগ্রাম': '2be20dd7-39d9-4cc3-bfaa-f13761210051',
    'বরিশাল': 'a0a290a7-4f6f-4e21-8550-58f45cc122d8',
    'খুলনা': 'cd7e4fe4-9e2d-452c-96ae-6632bd4069ed',
    'ময়মনসিংহ': '3ec0a8e8-7552-4a23-8774-07702414d2cb',
    'রাজশাহী': 'b65f7d01-b5f9-4bd6-a124-4b7bb6d13641',
    'রংপুর': '8d02cf87-d0db-4112-b961-dcaceb68c084',
    'সিলেট': '9d15504f-4f19-4403-b2c3-ed686797864c',
  };

  void _createAnnouncement() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref
        .read(announcementControllerProvider.notifier)
        .createAnnouncement(
          context,
          _nameController.text.trim(),
          _selectedDivisionId!,
        );

    FocusScope.of(context).unfocus();
    _formKey.currentState!.reset();
    _nameController.clear();
    _selectedDivisionId = null;
  }

  String? _selectedDivisionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
                child: DropdownButtonFormField<String>(
                  value: _selectedDivisionId,
                  decoration: InputDecoration(
                    hintText: 'বিভাগ*',
                    labelText: 'বিভাগ',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      _divisionMap.entries.map((entry) {
                        return DropdownMenuItem(
                          value: entry.value, // Store the division ID
                          child: Text(entry.key), // Display Bangla division name
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDivisionId = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null) {
                      return 'বিভাগ দিন';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                child: TextFormField(
                  controller: _nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: 5,
                  decoration: InputDecoration(
                    label: Text('ঘোষণা *'),
                    hintText: 'এখানে লিখুন',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'ঘোষণা লিঘুন';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ElevatedButton(
                  onPressed:    _createAnnouncement,
                  child: Text(
                    'ঘোষণা তৈরি করুন',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
