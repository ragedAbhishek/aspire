import 'dart:io';
import 'package:aspire/Utils/methods.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> resumeTwo({
  bool? hasSaved,
  bool? isServerData,
  bool? isBlackNWhite,
  String? firstName,
  String? lastName,
  String? designation,
  String? address,
  String? emailAddress,
  String? phoneNo,
  String? imagePath,
  List? skill,
  List? education,
  List? experience,
  List? project,
  List? certificate,
  String? profile,
  String? countryCode,
}) async {
  final resume2 = Document();

  final image = hasSaved!
      ? await networkImage(imagePath.toString())
      : isServerData!
          ? isBlackNWhite!
              ? MemoryImage(
                  File(imagePath.toString()).readAsBytesSync(),
                )
              : await networkImage(imagePath.toString())
          : MemoryImage(
              File(imagePath.toString()).readAsBytesSync(),
            );
  final theFont = await PdfGoogleFonts.poppinsSemiBold();

  final emailIconWhite = MemoryImage(
      (await rootBundle.load('assets/icons/emailWhite.png'))
          .buffer
          .asUint8List());
  final phoneCallIconWhite = MemoryImage(
      (await rootBundle.load('assets/icons/phoneCallWhite.png'))
          .buffer
          .asUint8List());
  final pinIconWhite = MemoryImage(
      (await rootBundle.load('assets/icons/pinWhite.png'))
          .buffer
          .asUint8List());

  resume2.addPage(
    Page(
      pageFormat: PdfPageFormat.standard.copyWith(
        marginLeft: 0,
        marginRight: 0,
        marginTop: 0,
        marginBottom: 0,
      ),
      build: (context) {
        return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 220,
                  height: double.infinity,
                  decoration:
                      const BoxDecoration(color: PdfColor.fromInt(0xFF363636)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 32),
                        Center(
                            child: Container(
                          height: 108,
                          width: 108,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: image,
                              )),
                        )),
                        Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text("PROFILE",
                                      style: TextStyle(
                                          color: PdfColors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 6),
                                  Container(
                                      width: 20,
                                      height: 1.4,
                                      color: PdfColors.white),
                                  SizedBox(height: 12),
                                  Container(
                                      width: 172,
                                      // color: PdfColors.red100,
                                      child: Text(profile.toString(),
                                          maxLines: 11,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: PdfColors.white,
                                              fontWeight: FontWeight.normal))),
                                  SizedBox(height: 32),
                                  Text("CONTACT",
                                      style: TextStyle(
                                          color: PdfColors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 6),
                                  Container(
                                      width: 20,
                                      height: 1.4,
                                      color: PdfColors.white),
                                  SizedBox(height: 12),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image(
                                            height: 15,
                                            width: 15,
                                            phoneCallIconWhite),
                                        SizedBox(width: 12),
                                        Container(
                                            width: 142,
                                            // color: PdfColors.amber500,
                                            child: RichText(
                                                maxLines: 3,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "Phone\n",
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 11)),
                                                  TextSpan(
                                                      text:
                                                          "${countryCodeToDailingCode(countryCode)} ${phoneNo.toString()}",
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 11))
                                                ])))
                                      ]),
                                  SizedBox(height: 12),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image(
                                            height: 15,
                                            width: 15,
                                            emailIconWhite),
                                        SizedBox(width: 12),
                                        Container(
                                            width: 142,
                                            // color: PdfColors.amber500,
                                            child: RichText(
                                                maxLines: 3,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "Email\n",
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 11)),
                                                  TextSpan(
                                                      text: emailAddress
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 11))
                                                ])))
                                      ]),
                                  SizedBox(height: 12),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image(
                                            height: 15,
                                            width: 15,
                                            pinIconWhite),
                                        SizedBox(width: 12),
                                        Container(
                                            width: 142,
                                            // color: PdfColors.amber500,
                                            child: RichText(
                                                maxLines: 3,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "Address\n",
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 11)),
                                                  TextSpan(
                                                      text: address.toString(),
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 11))
                                                ])))
                                      ]),
                                  skill!.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 32),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("SKILLS",
                                          style: TextStyle(
                                              color: PdfColors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 6),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : Container(
                                          width: 20,
                                          height: 1.4,
                                          color: PdfColors.white),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 12),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : ListView.builder(
                                          itemCount: skill
                                              .length, // the number of items in the list
                                          itemBuilder: (context, int index) {
                                            final skills = skill[
                                                index]; // get the skill at the current index
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          width: 80,
                                                          // color: PdfColors
                                                          //     .amber900,
                                                          child: Text(
                                                              skills.skillName
                                                                  .toString(),
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  color:
                                                                      PdfColors
                                                                          .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal))),
                                                      SizedBox(width: 16),
                                                      Container(
                                                          width: 70,
                                                          height: 2.5,
                                                          child: LinearProgressIndicator(
                                                              value: skills
                                                                  .expertise,
                                                              backgroundColor:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFfAAAAAA),
                                                              valueColor:
                                                                  PdfColors
                                                                      .white,
                                                              minHeight: 5))
                                                    ]));
                                          })
                                ]))
                      ])),
              SizedBox(width: 20),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Container(
                        width: 320,
                        // color: PdfColors.amber900,
                        child: Text(
                            "${firstName.toString().toUpperCase()} ${lastName.toString().toUpperCase()}",
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: PdfColors.black,
                              font: theFont,
                              fontSize: 32,
                            ))),
                    SizedBox(height: 2),
                    Container(
                      width: 260,
                      // color: PdfColors.amber900,
                      child: Text(designation.toString().toUpperCase(),
                          maxLines: 1,
                          style: TextStyle(
                              color: const PdfColor.fromInt(0xFF777777),
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 36),
                    education!.isEmpty
                        ? SizedBox(height: 0)
                        : Text("EDUCATION",
                            style: TextStyle(
                                color: PdfColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                    education.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 6),
                    education.isEmpty
                        ? SizedBox(height: 0)
                        : Container(
                            width: 20, height: 1.4, color: PdfColors.black),
                    education.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 12),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 320,
                                            // color: PdfColors.orange,
                                            child: Text(
                                                educations.degree
                                                    .toString()
                                                    .toUpperCase(),
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF363636),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11))),
                                        Container(
                                            width: 320,
                                            // color: PdfColors.orange,
                                            child: Text(
                                                "${educations.schoolOrCollege.toString()}, ${educations.city.toString()}",
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF777777),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11))),
                                        Container(
                                            width: 320,
                                            // color: PdfColors.orange,
                                            child: Text(
                                                "${educations.start} - ${educations.end}",
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF777777),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11)))
                                      ]));
                            },
                          ),
                    education.isEmpty
                        ? SizedBox(height: 0)
                        : education.isEmpty
                            ? SizedBox(height: 36)
                            : SizedBox(height: 26),
                    experience!.isEmpty
                        ? SizedBox(height: 0)
                        : Text("WORK EXPERIENCE",
                            style: TextStyle(
                                color: PdfColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                    experience.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 6),
                    experience.isEmpty
                        ? SizedBox(height: 0)
                        : Container(
                            width: 20, height: 1.4, color: PdfColors.black),
                    experience.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 12),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 320,
                                          child: Text(
                                              experiences.jobTitle
                                                  .toString()
                                                  .toUpperCase(),
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: const PdfColor.fromInt(
                                                      0xFF363636),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11)),
                                        ),
                                        Container(
                                            width: 320,
                                            child: Text(
                                                "${experiences.employer.toString()}, ${experiences.city.toString()}",
                                                overflow: TextOverflow.clip,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF777777),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11))),
                                        Container(
                                          width: 320,
                                          child: Text(
                                              "${experiences.start} - ${experiences.end}",
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: const PdfColor.fromInt(
                                                      0xFF777777),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 11)),
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          width: 320,
                                          child: Text(
                                              experiences.description
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: const PdfColor.fromInt(
                                                      0xFF777777),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 11)),
                                        ),
                                      ]));
                            },
                          ),
                    project!.isEmpty
                        ? SizedBox(height: 0)
                        : experience.isEmpty || education.isEmpty
                            ? SizedBox(height: 36)
                            : SizedBox(height: 26),
                    project.isEmpty
                        ? SizedBox(height: 0)
                        : Text("EXPERIENCE",
                            style: TextStyle(
                                color: PdfColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                    project.isEmpty ? SizedBox(height: 0) : SizedBox(height: 6),
                    project.isEmpty
                        ? SizedBox(height: 0)
                        : Container(
                            width: 20, height: 1.4, color: PdfColors.black),
                    project.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 12),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 320,
                                          child: Text(
                                              projects.projectName
                                                  .toString()
                                                  .toUpperCase(),
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: const PdfColor.fromInt(
                                                      0xFF363636),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11)),
                                        ),
                                        Container(
                                            width: 320,
                                            child: Text(projects.projectDate,
                                                overflow: TextOverflow.clip,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF777777),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11))),
                                        SizedBox(height: 4),
                                        Container(
                                          width: 320,
                                          child: Text(
                                              projects.projectDescription
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: const PdfColor.fromInt(
                                                      0xFF777777),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 11)),
                                        ),
                                      ]));
                            },
                          ),
                    certificate!.isEmpty
                        ? SizedBox(height: 0)
                        : experience.isEmpty ||
                                education.isEmpty ||
                                project.isEmpty
                            ? SizedBox(height: 36)
                            : SizedBox(height: 26),
                    certificate.isEmpty
                        ? SizedBox(height: 0)
                        : Text("CERTIFICATES",
                            style: TextStyle(
                                color: PdfColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                    certificate.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 6),
                    certificate.isEmpty
                        ? SizedBox(height: 0)
                        : Container(
                            width: 20, height: 1.4, color: PdfColors.black),
                    certificate.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 12),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 320,
                                          child: Text(
                                              certificates.issuedFor
                                                  .toString()
                                                  .toUpperCase(),
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: const PdfColor.fromInt(
                                                      0xFF363636),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11)),
                                        ),
                                        Container(
                                            width: 320,
                                            child: Text(
                                                "${certificates.issuingBody}, ${certificates.issuedOn}",
                                                overflow: TextOverflow.clip,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF777777),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11))),
                                      ]));
                            },
                          ),
                  ])
            ]);
      },
    ),
  );
  return resume2.save();
}
