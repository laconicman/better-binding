import Testing
import SwiftUI
@testable import BetterBinding

@Suite("Default-to-Nil Operator Tests")

/// Swift Testing implementation for the ??? operator
struct DefaultToNilOperatorSwiftTests {
    
    // MARK: - String Tests
    
    @Test("String get behavior returns default when optional is nil")
    func stringGetBehavior() {
        // Given
        var optionalString: String? = nil
        let binding = Binding(
            get: { optionalString },
            set: { optionalString = $0 }
        )
        let defaultValue = "default"
        
        // When
        let nonOptionalBinding = binding ??? defaultValue
        
        // Then
        #expect(nonOptionalBinding.wrappedValue == defaultValue)
    }
    
    @Test("String set to default value sets optional to nil")
    func stringSetToDefault() {
        // Given
        var optionalString: String? = "some value"
        let binding = Binding(
            get: { optionalString },
            set: { optionalString = $0 }
        )
        let defaultValue = "default"
        let nonOptionalBinding = binding ??? defaultValue
        
        // When
        nonOptionalBinding.wrappedValue = defaultValue
        
        // Then
        #expect(optionalString == nil)
    }
    
    @Test("String set to non-default value sets optional to that value")
    func stringSetToNonDefault() {
        // Given
        var optionalString: String? = nil
        let binding = Binding(
            get: { optionalString },
            set: { optionalString = $0 }
        )
        let defaultValue = "default"
        let nonOptionalBinding = binding ??? defaultValue
        let newValue = "new value"
        
        // When
        nonOptionalBinding.wrappedValue = newValue
        
        // Then
        #expect(optionalString == newValue)
    }
    
    // MARK: - Integer Tests
    
    @Test("Integer get behavior returns default when optional is nil")
    func intGetBehavior() {
        // Given
        var optionalInt: Int? = nil
        let binding = Binding(
            get: { optionalInt },
            set: { optionalInt = $0 }
        )
        let defaultValue = 0
        
        // When
        let nonOptionalBinding = binding ??? defaultValue
        
        // Then
        #expect(nonOptionalBinding.wrappedValue == defaultValue)
    }
    
    @Test("Integer set to default value sets optional to nil")
    func intSetToDefault() {
        // Given
        var optionalInt: Int? = 42
        let binding = Binding(
            get: { optionalInt },
            set: { optionalInt = $0 }
        )
        let defaultValue = 0
        let nonOptionalBinding = binding ??? defaultValue
        
        // When
        nonOptionalBinding.wrappedValue = defaultValue
        
        // Then
        #expect(optionalInt == nil)
    }
    
    @Test("Integer set to non-default value sets optional to that value")
    func intSetToNonDefault() {
        // Given
        var optionalInt: Int? = nil
        let binding = Binding(
            get: { optionalInt },
            set: { optionalInt = $0 }
        )
        let defaultValue = 0
        let nonOptionalBinding = binding ??? defaultValue
        let newValue = 100
        
        // When
        nonOptionalBinding.wrappedValue = newValue
        
        // Then
        #expect(optionalInt == newValue)
    }
    
    // MARK: - Boolean Tests
    
    @Test("Boolean get behavior returns default when optional is nil")
    func boolGetBehavior() {
        // Given
        var optionalBool: Bool? = nil
        let binding = Binding(
            get: { optionalBool },
            set: { optionalBool = $0 }
        )
        let defaultValue = false
        
        // When
        let nonOptionalBinding = binding ??? defaultValue
        
        // Then
        #expect(nonOptionalBinding.wrappedValue == defaultValue)
    }
    
    @Test("Boolean toggle behavior works correctly")
    func boolToggleBehavior() {
        // Given
        var optionalBool: Bool? = nil
        let binding = Binding(
            get: { optionalBool },
            set: { optionalBool = $0 }
        )
        let defaultValue = false
        let nonOptionalBinding = binding ??? defaultValue
        
        // When - Set to true (non-default)
        nonOptionalBinding.wrappedValue = true
        
        // Then
        #expect(optionalBool == true)
        
        // When - Toggle back to false (default)
        nonOptionalBinding.wrappedValue = false
        
        // Then
        #expect(optionalBool == nil)
    }
    
    // MARK: - Custom Type Tests
    
    struct TestStruct: Equatable {
        let name: String
        let value: Int
        
        static let defaultInstance = TestStruct(name: "default", value: 0)
    }
    
    @Test("Custom type get behavior returns default when optional is nil")
    func customTypeGetBehavior() {
        // Given
        var optionalStruct: TestStruct? = nil
        let binding = Binding(
            get: { optionalStruct },
            set: { optionalStruct = $0 }
        )
        let defaultValue = TestStruct.defaultInstance
        
        // When
        let nonOptionalBinding = binding ??? defaultValue
        
        // Then
        #expect(nonOptionalBinding.wrappedValue == defaultValue)
    }
    
    @Test("Custom type set to default value sets optional to nil")
    func customTypeSetToDefault() {
        // Given
        var optionalStruct: TestStruct? = TestStruct(name: "test", value: 42)
        let binding = Binding(
            get: { optionalStruct },
            set: { optionalStruct = $0 }
        )
        let defaultValue = TestStruct.defaultInstance
        let nonOptionalBinding = binding ??? defaultValue
        
        // When
        nonOptionalBinding.wrappedValue = defaultValue
        
        // Then
        #expect(optionalStruct == nil)
    }
    
    // MARK: - Edge Cases
    
    @Test("Multiple sets to default keep optional nil")
    func multipleSetToDefault() {
        // Given
        var optionalString: String? = "initial"
        let binding = Binding(
            get: { optionalString },
            set: { optionalString = $0 }
        )
        let defaultValue = "default"
        let nonOptionalBinding = binding ??? defaultValue
        
        // When - Set to default multiple times
        nonOptionalBinding.wrappedValue = defaultValue
        nonOptionalBinding.wrappedValue = defaultValue
        nonOptionalBinding.wrappedValue = defaultValue
        
        // Then
        #expect(optionalString == nil)
    }
    
    @Test("Alternating between default and non-default values")
    func alternatingValues() {
        // Given
        var optionalInt: Int? = nil
        let binding = Binding(
            get: { optionalInt },
            set: { optionalInt = $0 }
        )
        let defaultValue = 0
        let nonOptionalBinding = binding ??? defaultValue
        
        // Test sequence of operations
        nonOptionalBinding.wrappedValue = 5
        #expect(optionalInt == 5)
        
        nonOptionalBinding.wrappedValue = defaultValue
        #expect(optionalInt == nil)
        #expect(nonOptionalBinding.wrappedValue == defaultValue)
        
        nonOptionalBinding.wrappedValue = 10
        #expect(optionalInt == 10)
    }
    
    @Test("Empty string as default works correctly")
    func emptyStringAsDefault() {
        // Given
        var optionalString: String? = "not empty"
        let binding = Binding(
            get: { optionalString },
            set: { optionalString = $0 }
        )
        let nonOptionalBinding = binding ??? ""
        
        // When
        nonOptionalBinding.wrappedValue = ""
        
        // Then
        #expect(optionalString == nil)
    }
    
    @Test("Zero as numeric default works correctly")
    func zeroAsDefault() {
        // Given
        var optionalDouble: Double? = 3.14
        let binding = Binding(
            get: { optionalDouble },
            set: { optionalDouble = $0 }
        )
        let nonOptionalBinding = binding ??? 0.0
        
        // When
        nonOptionalBinding.wrappedValue = 0.0
        
        // Then
        #expect(optionalDouble == nil)
        
        // When reading back
        #expect(nonOptionalBinding.wrappedValue == 0.0)
    }
}

// MARK: - SwiftUI Integration Tests

@Suite("SwiftUI Integration Tests")

struct SwiftUIIntegrationTests {
    
    @Test("TextField-like binding behavior")
    func textFieldBindingIntegration() {
        // Given
        var text: String? = nil
        let binding = Binding(get: { text }, set: { text = $0 })
        
        // When
        let textFieldBinding = binding ??? "placeholder"
        
        // Then - Initial state
        #expect(textFieldBinding.wrappedValue == "placeholder")
        
        // Simulate user typing
        textFieldBinding.wrappedValue = "user input"
        #expect(text == "user input")
        
        // Simulate user clearing field back to placeholder
        textFieldBinding.wrappedValue = "placeholder"
        #expect(text == nil)
    }
    
    @Test("Toggle-like binding behavior")
    func toggleBindingIntegration() {
        // Given
        var isEnabled: Bool? = nil
        let binding = Binding(get: { isEnabled }, set: { isEnabled = $0 })
        
        // When
        let toggleBinding = binding ??? false
        
        // Then - Initial state (nil -> false)
        #expect(toggleBinding.wrappedValue == false)
        
        // Simulate toggle on
        toggleBinding.wrappedValue = true
        #expect(isEnabled == true)
        
        // Simulate toggle off (back to default)
        toggleBinding.wrappedValue = false
        #expect(isEnabled == nil)
    }
    
    @Test("Numeric field binding behavior")
    func numericFieldIntegration() {
        // Given
        var quantity: Int? = nil
        let binding = Binding(get: { quantity }, set: { quantity = $0 })
        
        // When
        let numericBinding = binding ??? 0
        
        // Then - Initial state
        #expect(numericBinding.wrappedValue == 0)
        
        // Simulate user entering quantity
        numericBinding.wrappedValue = 5
        #expect(quantity == 5)
        
        // Simulate user clearing back to zero
        numericBinding.wrappedValue = 0
        #expect(quantity == nil)
    }
    
    @Test("Stepper-like binding behavior")
    func stepperBindingIntegration() {
        // Given
        var count: Int? = nil
        let binding = Binding(get: { count }, set: { count = $0 })
        let stepperBinding = binding ??? 0
        
        // Initial state
        #expect(stepperBinding.wrappedValue == 0)
        #expect(count == nil)
        
        // Simulate increment
        stepperBinding.wrappedValue = 1
        #expect(count == 1)
        
        // Simulate decrement back to zero
        stepperBinding.wrappedValue = 0
        #expect(count == nil)
        #expect(stepperBinding.wrappedValue == 0)
    }
}

// MARK: - Performance Tests

@Suite("Performance Tests")
struct PerformanceTests {
    
    @Test("Performance of repeated operations", .timeLimit(.minutes(1)))
    func performanceTest() {
        // Given
        var optionalInt: Int? = nil
        let binding = Binding(
            get: { optionalInt },
            set: { optionalInt = $0 }
        )
        let nonOptionalBinding = binding ??? 0
        
        // When/Then - Should complete within time limit
        for i in 0...100000 {
            nonOptionalBinding.wrappedValue = i % 2 == 0 ? 0 : i
        }
        
        // Verify final state
        #expect(optionalInt == nil) // Last iteration was even (0)
    }
    
    @Test("Performance with string operations", .timeLimit(.minutes(1)))
    func stringPerformanceTest() {
        // Given
        var optionalString: String? = nil
        let binding = Binding(
            get: { optionalString },
            set: { optionalString = $0 }
        )
        let nonOptionalBinding = binding ??? ""
        
        // When/Then
        for i in 0...100000 {
            nonOptionalBinding.wrappedValue = i % 2 == 0 ? "" : "value \(i)"
        }
        
        // Verify final state
        #expect(optionalString == nil) // Last iteration was even (empty string)
    }
}

// MARK: - Error Conditions Tests

@Suite("Error Conditions and Edge Cases")
struct EdgeCaseTests {
    
    @Test("Floating point precision with defaults")
    func floatingPointPrecision() {
        // Given
        var optionalFloat: Float? = nil
        let binding = Binding(
            get: { optionalFloat },
            set: { optionalFloat = $0 }
        )
        let nonOptionalBinding = binding ??? Float(0.0)
        
        // Test very small numbers
        nonOptionalBinding.wrappedValue = 0.0000001
        #expect(optionalFloat != nil)
        
        nonOptionalBinding.wrappedValue = 0.0
        #expect(optionalFloat == nil)
    }
    
    @Test("Large numbers as defaults")
    func largeNumberDefaults() {
        // Given
        var optionalInt: Int? = 42
        let binding = Binding(
            get: { optionalInt },
            set: { optionalInt = $0 }
        )
        let largeDefault = Int.max
        let nonOptionalBinding = binding ??? largeDefault
        
        // When setting to large default
        nonOptionalBinding.wrappedValue = largeDefault
        
        // Then
        #expect(optionalInt == nil)
        #expect(nonOptionalBinding.wrappedValue == largeDefault)
    }
    
    @Test("Unicode strings as defaults")
    func unicodeStringDefaults() {
        // Given
        var optionalString: String? = "test"
        let binding = Binding(
            get: { optionalString },
            set: { optionalString = $0 }
        )
        let unicodeDefault = "🚀✨🎉"
        let nonOptionalBinding = binding ??? unicodeDefault
        
        // When
        nonOptionalBinding.wrappedValue = unicodeDefault
        
        // Then
        #expect(optionalString == nil)
        #expect(nonOptionalBinding.wrappedValue == unicodeDefault)
    }
}
