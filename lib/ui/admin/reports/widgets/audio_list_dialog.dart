import 'package:flutter/material.dart';
import 'package:rooted_web/models/admin/recorded_note.dart';
import 'package:rooted_web/ui/widgets/error_dialog.dart';

import '../../../../models/admin/chapter_data.dart';
import '../../../../models/admin/record_link.dart';
import 'package:universal_html/html.dart' as html;

class AudioListDialog extends StatelessWidget {
  final ChapterData chapterData;

  const AudioListDialog({required this.chapterData, super.key});

  @override
  Widget build(BuildContext context) {
    List<RecordLink> recordLinks = [];
    recordLinks.add(RecordLink(
        url: chapterData.audioUrl,
        name: '${chapterData.book} ${chapterData.number}.mp3',
        type: 'main',),);
    for (RecordedNote note in chapterData.recordedNotes) {
      recordLinks.add(RecordLink(
          url: note.url,
          name:
              'Note ${chapterData.book} ${chapterData.number} ${note.location}.mp3',
          type: 'note',),);
    }
    return AlertDialog(
      content: SizedBox(
        width: 350,
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${chapterData.book} ${chapterData.number} Recordings:',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: recordLinks.length,
                    itemBuilder: (context, index) {
                      final RecordLink recordLink = recordLinks[index];
                      return ListTile(
                        leading: Icon(recordLink.type == 'main'
                            ? Icons.record_voice_over
                            : Icons.notes,),
                        title: Text(recordLink.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () =>
                              downloadAudio(recordLink: recordLink),
                        ),
                      );
                    },),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Done'),),
                  TextButton(
                      onPressed: () async => await _handleDelete(context),
                      child: const Text('DELETE'),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void downloadAudio({required RecordLink recordLink}) {
    final String fileName = recordLink.name;
    final String url = recordLink.url;

    html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
  }

  Future<void> _handleDelete(BuildContext context) async {
    try {
      // TODO: Handle Delete Recording
    } catch (e) {
      errorDialog(e.toString(), context);
    }
  }
}
