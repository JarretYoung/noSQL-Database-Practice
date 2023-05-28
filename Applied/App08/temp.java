import java.util.*;

public class temp {
    public static void main(String[] arg) {
        ArrayList <String> temp = new ArrayList<>();
        temp.add("c");
        temp.add("b");
        temp.add("a");
        // String c = temp.remove(temp.size() -1);

        ArrayList<Object> arrl = new ArrayList<>();
        arrl.add(0.5);
        arrl.add('%');
        System.out.println(format("{0}", new ArrayList<>(Arrays.asList(0.5, "%"))));
    }

    public static String format(String formatString, ArrayList<Object> argsList) {
        StringBuilder sb = new StringBuilder();
        int i = 0;
        int length = formatString.length();
        while (i < length) {
            char c = formatString.charAt(i);
            if (c == '{') {
                int start = i;
                int end = formatString.indexOf('}', start + 1);
                if (end == -1) {
                    throw new IllegalArgumentException("Invalid format string");
                }
                String indexStr = formatString.substring(start + 1, end);
                int index;
                try {
                    index = Integer.parseInt(indexStr);
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Invalid format string: " + indexStr);
                }
                if (index < 0 || index >= argsList.size()) {
                    throw new IllegalArgumentException("Index out of bounds: " + index);
                }
                Object arg = argsList.get(index);
                String formatSpec = null;
                if (end + 1 < length && formatString.charAt(end + 1) == ':') {
                    int specStart = end + 2;
                    int specEnd = findFormatSpecEnd(formatString, specStart);
                    formatSpec = formatString.substring(specStart, specEnd);
                    i = specEnd;
                } else {
                    i = end + 1;
                }
                sb.append(formatArg(arg, formatSpec));
            } else {
                sb.append(c);
                i++;
            }
        }
        return sb.toString();
    }

    private static int findFormatSpecEnd(String formatString, int start) {
        int length = formatString.length();
        int depth = 0;
        for (int i = start; i < length; i++) {
            char c = formatString.charAt(i);
            if (c == '{') {
                depth++;
            } else if (c == '}') {
                if (depth == 0) {
                    return i;
                } else {
                    depth--;
                }
            }
        }
        throw new IllegalArgumentException("Invalid format string");
    }

    private static String formatArg(Object arg, String formatSpec) {
        if (formatSpec == null) {
            return arg.toString();
        }
        // Implement the format specifiers here
        return String.format(formatSpec, arg);
    }
}