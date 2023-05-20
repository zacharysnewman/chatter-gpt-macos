
import AVFoundation

class SpeechVoices {
    static let enUSFlo = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-US.Flo")
    static let enUSBahh = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Bahh")
    static let enUSAlbert = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Albert")
    static let enUSFred = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Fred")
    static let enUSHysterical = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Hysterical")
    static let enUSOrgan = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Organ")
    static let enUSCellos = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Cellos")
    static let enUSZarvox = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Zarvox")
    static let enUSRocko = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-US.Rocko")
    static let enUSShelley = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-US.Shelley")
    static let enUSPrincess = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Princess")
    static let enUSGrandma = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-US.Grandma")
    static let enUSEddy = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-US.Eddy")
    static let enUSBells = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Bells")
    static let enUSGrandpa = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-US.Grandpa")
    static let enUSTrinoids = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Trinoids")
    static let enUSKathy = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Kathy")
    static let enUSReed = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-US.Reed")
    static let enUSBoing = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Boing")
    static let enUSWhisper = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Whisper")
    static let enUSGoodNews = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.GoodNews")
    static let enUSDeranged = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Deranged")
    static let enUSNicky = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_Nicky_en-US_compact")
    static let enUSBadNews = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.BadNews")
    static let enUSAaron = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_Aaron_en-US_compact")
    static let enUSBubbles = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Bubbles")
    static let enUSSamantha = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-US.Samantha")
    static let enUSSandy = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-US.Sandy")
    static let enAUGordon = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_Gordon_en-AU_compact")
    static let enAUKaren = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-AU.Karen")
    static let enAUCatherine = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_Catherine_en-AU_compact")
    static let enGBRocko = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-GB.Rocko")
    static let enGBShelley = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-GB.Shelley")
    static let enGBDaniel = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-GB.Daniel")
    static let enGBMartha = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_Martha_en-GB_compact")
    static let enGBGrandma = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-GB.Grandma")
    static let enGBGrandpa = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-GB.Grandpa")
    static let enGBFlo = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-GB.Flo")
    static let enGBEddy = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-GB.Eddy")
    static let enGBReed = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-GB.Reed")
    static let enGBSandy = AVSpeechSynthesisVoice(identifier: "com.apple.eloquence.en-GB.Sandy")
    static let enGBArthur = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_Arthur_en-GB_compact")
    static let enIEMoira = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-IE.Moira")
    static let enINRishi = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-IN.Rishi")
    static let enZATessa = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-ZA.Tessa")

    static let allVoices: [(name: String, voice: AVSpeechSynthesisVoice?)] = [
        ("en-US Flo", enUSFlo),
        ("en-US Bahh", enUSBahh),
        ("en-US Albert", enUSAlbert),
        ("en-US Fred", enUSFred),
        ("en-US Hysterical", enUSHysterical),
        ("en-US Organ", enUSOrgan),
        ("en-US Cellos", enUSCellos),
        ("en-US Zarvox", enUSZarvox),
        ("en-US Rocko", enUSRocko),
        ("en-US Shelley", enUSShelley),
        ("en-US Princess", enUSPrincess),
        ("en-US Grandma", enUSGrandma),
        ("en-US Eddy", enUSEddy),
        ("en-US Bells", enUSBells),
        ("en-US Grandpa", enUSGrandpa),
        ("en-US Trinoids", enUSTrinoids),
        ("en-US Kathy", enUSKathy),
        ("en-US Reed", enUSReed),
        ("en-US Boing", enUSBoing),
        ("en-US Whisper", enUSWhisper),
        ("en-US Good News", enUSGoodNews),
        ("en-US Deranged", enUSDeranged),
        ("en-US Nicky", enUSNicky),
        ("en-US Bad News", enUSBadNews),
        ("en-US Aaron", enUSAaron),
        ("en-US Bubbles", enUSBubbles),
        ("en-US Samantha", enUSSamantha),
        ("en-US Sandy", enUSSandy),
        ("en-AU Gordon", enAUGordon),
        ("en-AU Karen", enAUKaren),
        ("en-AU Catherine", enAUCatherine),
        ("en-GB Rocko", enGBRocko),
        ("en-GB Shelley", enGBShelley),
        ("en-GB Daniel", enGBDaniel),
        ("en-GB Martha", enGBMartha),
        ("en-GB Grandma", enGBGrandma),
        ("en-GB Grandpa", enGBGrandpa),
        ("en-GB Flo", enGBFlo),
        ("en-GB Eddy", enGBEddy),
        ("en-GB Reed", enGBReed),
        ("en-GB Sandy", enGBSandy),
        ("en-GB Arthur", enGBArthur),
        ("en-IE Moira", enIEMoira),
        ("en-IN Rishi", enINRishi),
        ("en-ZA Tessa", enZATessa)
    ]
}
