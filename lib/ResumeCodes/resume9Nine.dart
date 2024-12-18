import 'package:aspire/Utils/methods.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> resumeNine({
  bool? hasSaved,
  String? firstName,
  String? lastName,
  String? designation,
  String? address,
  String? emailAddress,
  String? phoneNo,
  List? skill,
  List? education,
  List? experience,
  List? project,
  List? certificate,
  String? profile,
  String? countryCode,
}) async {
  final resume9 = Document();
  final emailIconBlack = MemoryImage(
      (await rootBundle.load('assets/icons/emailBlack.png'))
          .buffer
          .asUint8List());
  final phoneCallIconBlack = MemoryImage(
      (await rootBundle.load('assets/icons/phoneCallBlack.png'))
          .buffer
          .asUint8List());
  final pinIconBlack = MemoryImage(
      (await rootBundle.load('assets/icons/pinBlack.png'))
          .buffer
          .asUint8List());

  resume9.addPage(
    Page(
      pageFormat: PdfPageFormat.standard.copyWith(
        marginLeft: 0,
        marginRight: 0,
        marginTop: 0,
        marginBottom: 0,
      ),
      build: (context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  height: 132,
                  color: PdfColor.fromHex("#F1F1F1"),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 56),
                            Container(
                                width: 432,
                                // color: PdfColors.lightGreenAccent700,
                                child: Text(
                                    "${firstName.toString().toUpperCase()} ${lastName.toString().toUpperCase()}",
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 28,
                                        letterSpacing: 4,
                                        fontWeight: FontWeight.normal))),
                            SizedBox(height: 2),
                            Container(
                                width: 432,
                                // color: PdfColors.lightGreenAccent700,
                                child: Text(
                                    designation.toString().toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color:
                                            const PdfColor.fromInt(0xFF444343),
                                        fontSize: 12,
                                        letterSpacing: 4,
                                        fontWeight: FontWeight.normal)))
                          ]))),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 390,
                        height: 709,
                        // color: PdfColors.lightGreenAccent700,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 26),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text("PROFESSIONAL PROFILE",
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                          fontSize: 13)),
                                  SizedBox(height: 8),
                                  Container(
                                      height: 1,
                                      width: 364,
                                      color: PdfColor.fromHex("#F1F1F1")),
                                  SizedBox(height: 16),
                                  Container(
                                      width: 364,
                                      child: Text(profile.toString(),
                                          maxLines: 5,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal,
                                            color: const PdfColor.fromInt(
                                                0xFF444343),
                                          ))),
                                  experience!.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 32),
                                  experience.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("WORK EXPERIENCE",
                                          style: TextStyle(
                                              color: PdfColors.black,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 2,
                                              fontSize: 13)),
                                  experience.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 8),
                                  experience.isEmpty
                                      ? SizedBox(height: 0)
                                      : Container(
                                          height: 1,
                                          width: 364,
                                          color: PdfColor.fromHex("#F1F1F1")),
                                  experience.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 16),
                                  experience.isEmpty
                                      ? SizedBox(height: 0)
                                      : ListView.builder(
                                          reverse: true,
                                          itemCount: experience
                                              .length, // the number of items in the list
                                          itemBuilder: (context, int index) {
                                            final experiences = experience[
                                                index]; // get the skill at the current index
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 364,
                                                        child: Text(
                                                            experiences.jobTitle
                                                                .toString()
                                                                .toUpperCase(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                                color: PdfColors
                                                                    .black,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Container(
                                                        width: 364,
                                                        child: Text(
                                                            "${experiences.employer.toString()}, ${experiences.city.toString()}  |  ${experiences.start.toString()} - ${experiences.end.toString()}",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF444343),
                                                            )),
                                                      ),
                                                      SizedBox(height: 6),
                                                      Container(
                                                        width: 364,
                                                        child: Text(
                                                            experiences
                                                                .description
                                                                .toString(),
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF444343),
                                                            )),
                                                      )
                                                    ]));
                                          },
                                        ),
                                  project!.isEmpty
                                      ? SizedBox(height: 0)
                                      : experience.isEmpty
                                          ? SizedBox(height: 32)
                                          : SizedBox(height: 12),
                                  project.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("EXPERIENCE",
                                          style: TextStyle(
                                              color: PdfColors.black,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 2,
                                              fontSize: 13)),
                                  project.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 8),
                                  project.isEmpty
                                      ? SizedBox(height: 0)
                                      : Container(
                                          height: 1,
                                          width: 364,
                                          color: PdfColor.fromHex("#F1F1F1")),
                                  project.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 16),
                                  project.isEmpty
                                      ? SizedBox(height: 0)
                                      : ListView.builder(
                                          reverse: true,
                                          itemCount: project
                                              .length, // the number of items in the list
                                          itemBuilder: (context, int index) {
                                            final projects = project[
                                                index]; // get the skill at the current index
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          width: 364,
                                                          child: RichText(
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text: projects
                                                                            .projectName
                                                                            .toString()
                                                                            .toUpperCase(),
                                                                        style: TextStyle(
                                                                            color: PdfColors
                                                                                .black,
                                                                            fontSize:
                                                                                11,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                    TextSpan(
                                                                        text:
                                                                            "  |  ${projects.projectDate.toString()}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          color: const PdfColor
                                                                              .fromInt(
                                                                              0xFF444343),
                                                                        ))
                                                                  ]))),
                                                      SizedBox(height: 6),
                                                      Container(
                                                        width: 364,
                                                        child: Text(
                                                            projects
                                                                .projectDescription
                                                                .toString(),
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF444343),
                                                            )),
                                                      )
                                                    ]));
                                          },
                                        ),
                                  certificate!.isEmpty
                                      ? SizedBox(height: 0)
                                      : experience.isEmpty || project.isEmpty
                                          ? SizedBox(height: 32)
                                          : SizedBox(height: 12),
                                  certificate.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("CERTIFICATE",
                                          style: TextStyle(
                                              color: PdfColors.black,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 2,
                                              fontSize: 13)),
                                  certificate.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 8),
                                  certificate.isEmpty
                                      ? SizedBox(height: 0)
                                      : Container(
                                          height: 1,
                                          width: 364,
                                          color: PdfColor.fromHex("#F1F1F1")),
                                  certificate.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 16),
                                  certificate.isEmpty
                                      ? SizedBox(height: 0)
                                      : ListView.builder(
                                          reverse: true,
                                          itemCount: certificate
                                              .length, // the number of items in the list
                                          itemBuilder: (context, int index) {
                                            final certificates = certificate[
                                                index]; // get the skill at the current index
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          width: 364,
                                                          child: RichText(
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text: certificates
                                                                            .issuedFor
                                                                            .toString()
                                                                            .toUpperCase(),
                                                                        style: TextStyle(
                                                                            color: PdfColors
                                                                                .black,
                                                                            fontSize:
                                                                                11,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                    TextSpan(
                                                                        text:
                                                                            "  |  ${certificates.issuingBody.toString()}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          color: const PdfColor
                                                                              .fromInt(
                                                                              0xFF444343),
                                                                        ))
                                                                  ]))),
                                                      SizedBox(height: 4),
                                                      Container(
                                                        width: 364,
                                                        // color: PdfColors.amber,
                                                        child: Text(
                                                            certificates
                                                                .issuedOn
                                                                .toString(),
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF444343),
                                                            )),
                                                      )
                                                    ]));
                                          },
                                        ),
                                ]))),
                    SizedBox(width: 12),
                    Container(
                        height: 709,
                        width: 1,
                        color: PdfColor.fromHex("#F1F1F1")),
                    SizedBox(width: 12),
                    Container(
                        width: 178,
                        // color: PdfColors.amberAccent100,
                        height: 709,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      height: 11,
                                      width: 11,
                                      phoneCallIconBlack,
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: 132,
                                      // color: PdfColors.red,
                                      child: Text(
                                          "${countryCodeToDailingCode(countryCode)} ${phoneNo.toString()}",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal,
                                            color: const PdfColor.fromInt(
                                                0xFF444343),
                                          )),
                                    )
                                  ]),
                              SizedBox(height: 12),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      height: 11,
                                      width: 11,
                                      emailIconBlack,
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: 132,
                                      // color: PdfColors.red,
                                      child: Text(emailAddress.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal,
                                            color: const PdfColor.fromInt(
                                                0xFF444343),
                                          )),
                                    )
                                  ]),
                              SizedBox(height: 12),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      height: 11,
                                      width: 11,
                                      pinIconBlack,
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: 132,
                                      // color: PdfColors.red,
                                      child: Text(address.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal,
                                            color: const PdfColor.fromInt(
                                                0xFF444343),
                                          )),
                                    )
                                  ]),
                              skill!.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 32),
                              skill.isEmpty
                                  ? SizedBox(height: 0)
                                  : Text("SKILLS",
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                          fontSize: 13)),
                              skill.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 8),
                              skill.isEmpty
                                  ? SizedBox(height: 0)
                                  : Container(
                                      height: 1,
                                      width: 152,
                                      color: PdfColor.fromHex("#F1F1F1")),
                              skill.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 16),
                              skill.isEmpty
                                  ? SizedBox(height: 0)
                                  : ListView.builder(
                                      itemCount: skill.length,
                                      itemBuilder: (context, int index) {
                                        final skills = skill[index];
                                        return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Container(
                                                width: 132,
                                                child: Text(
                                                    skills.skillName.toString(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF444343),
                                                        fontSize: 11,
                                                        fontWeight: FontWeight
                                                            .normal))));
                                      },
                                    ),
                              education!.isEmpty
                                  ? SizedBox(height: 0)
                                  : skill.isEmpty
                                      ? SizedBox(height: 32)
                                      : SizedBox(height: 24),
                              education.isEmpty
                                  ? SizedBox(height: 0)
                                  : Text("EDUCATION",
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                          fontSize: 13)),
                              education.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 8),
                              education.isEmpty
                                  ? SizedBox(height: 0)
                                  : Container(
                                      height: 1,
                                      width: 152,
                                      color: PdfColor.fromHex("#F1F1F1")),
                              education.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 16),
                              education.isEmpty
                                  ? SizedBox(height: 0)
                                  : ListView.builder(
                                      reverse: true,
                                      itemCount: education
                                          .length, // the number of items in the list
                                      itemBuilder: (context, int index) {
                                        final educations = education[
                                            index]; // get the skill at the current index
                                        return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 132,
                                                    child: Text(
                                                        educations.degree
                                                            .toString()
                                                            .toUpperCase(),
                                                        maxLines: 3,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            color:
                                                                PdfColors.black,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal)),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Container(
                                                      // color: PdfColors.amber100,
                                                      width: 132,
                                                      child: Text(
                                                          educations
                                                              .schoolOrCollege
                                                              .toString(),
                                                          maxLines: 3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF444343),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))),
                                                  SizedBox(height: 2),
                                                  Container(
                                                      // color: PdfColors
                                                      //     .amber100,
                                                      width: 132,
                                                      child: Text(
                                                          "${educations.start.toString()} - ${educations.end.toString()}",
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF444343),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)))
                                                ]));
                                      },
                                    ),
                            ]))
                  ]),
            ]);
      },
    ),
  );
  return resume9.save();
}
